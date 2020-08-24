# frozen_string_literal: true

require 'json'

class DataMapper
  def initialize(from_profile, to_profile, region = 'us-east-1', env = 'master')
    @from_profile = from_profile
    @to_profile = to_profile
    @region = region
    @env = env

    @command_base = "aws --profile #{@from_profile} \
    --region us-east-1 ssm get-parameters \
    --query 'Parameters[*].{Name:Name,Value:Value,Type:Type}' \
    --names"
  end

  def perform
    data.each do |param|
      param['Name'] = sanitize(param['Name'])
      `aws --profile #{@to_profile} --region #{@region} ssm put-parameter
      --cli-input-json '#{param.to_json}'`
    end
  end

  private

  def sanitize(name)
    cleaned = name.gsub(%r{^(\/master)}, '')
    return cleaned unless cleaned.scan(%r{\/}).length == 1 &&
                          cleaned.index('/').zero?

    cleaned.gsub(%r{\/}, '')
  end

  def process
    response = []
    parameters.each_slice(9) do |parameter_set|
      command = @command_base.dup
      parameter_set.each { |p| command << " #{p}" }
      response << JSON.parse(`#{command}`)
    end
    response
  end

  def data
    process.flatten(1)
  rescue StandardError => e
    puts "error reached #{e}"
  end

  # def source
  #   @source ||= JSON.parse(`aws --profile #{@from_profile} --region #{@region} \
  #                          ssm describe-parameters`)['Parameters']
  # end

  def param_names
    source.map { |x| x['Name'] }
  end

  def parameters
    @parameters ||= param_names.select { |p| p.include? @env }
  end
end

# DataMapper.new(*ARGV).perform
