# frozen_string_literal: true

require 'json'

# retrieve SSM parameters from profile
class Fetch
  def initialize(profile, region = 'us-east-1')
    @profile = profile
    @region = region
  end

  def parameters
    aws_ssm_keys
  end

  def parameters
    aws_ssm_keys['Parameters']
  end

  private

  def aws_ssm_keys
    JSON.parse(`aws --profile #{@profile} --region #{@region} ssm describe-parameters`)
  end
end
