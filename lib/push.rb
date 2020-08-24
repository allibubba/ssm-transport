# frozen_string_literal: true

require 'json'

# push SSM parameters to profile
class Push
  def self.trim_environment(name)
    cleaned = name.gsub(%r{^(\/master)}, '')
    return cleaned unless cleaned.scan(%r{\/}).length == 1 &&
                          cleaned.index('/').zero?

    cleaned.gsub(%r{\/}, '')
  end

  def initialize(profile, data, region = 'us-east-1', env = 'master')
    @profile = profile
    @data = data
    @region = region
    @env = env
  end

  def perform
    @data.each do |param|
      param['Name'] = self.class.trim_environment(param['Name'])
      `aws --profile #{@to_profile} --region #{@region} ssm put-parameter
      --cli-input-json '#{param.to_json}'`
      puts "Pushed #{param['Name']}"
    end
  end

end
