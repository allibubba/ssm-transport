# frozen_string_literal: true

require 'json'

# retrieve SSM parameter values and format
class KeyValues
  def initialize(profile, data, region = 'us-east-1', env = 'master')
    @profile = profile
    @data = data
    @region = region
    @env = env

    @command_base = "aws --profile #{@profile} \
    --region #{@region} ssm get-parameters \
    --query 'Parameters[*].{Name:Name,Value:Value,Type:Type}' \
    --names"
  end

  def format_data
    reference_data.flatten(1)
  rescue StandardError => e
    puts "error reached #{e}"
  end

  private

  def reference_data
    response = []
    parameters.each_slice(9) do |parameter_set|
      command = @command_base.dup
      parameter_set.each { |p| command << " #{p}" }
      response << JSON.parse(`#{command}`)
    end
    response
  end

  def param_names
    @data.map { |x| x['Name'] }
  end

  def parameters
    @parameters ||= param_names.select { |p| p.include? @env }
  end
end
