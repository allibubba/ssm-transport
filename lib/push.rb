# frozen_string_literal: true

require 'json'

# push SSM parameters to profile
class Push
  def initialize(profile, data, region = 'us-east-1', env = 'master')
    @profile = profile
    @data = data
    @region = region
    @env = env
  end

  def perform
    @data.each do |param|
      param['Name'] = sanitize(param['Name'])
      puts param['Name']
      # `aws --profile #{@to_profile} --region #{@region} ssm put-parameter
      # --cli-input-json '#{param.to_json}'`
    end
  end

  private

  def sanitize(name)
    cleaned = name.gsub(%r{^(\/master)}, '')
    return cleaned unless cleaned.scan(%r{\/}).length == 1 &&
                          cleaned.index('/').zero?

    cleaned.gsub(%r{\/}, '')
  end
end
