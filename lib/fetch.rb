# frozen_string_literal: true

require 'json'

# retrieve SSM parameters from profile
class Fetch
  def initialize(profile, region = 'us-east-1')
    @profile = profile
    @region = region
  end

  def parameters
    JSON.parse(`aws --profile #{@profile} --region #{@region} \
                ssm describe-parameters`)['Parameters']
  end
end
