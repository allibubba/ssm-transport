# frozen_string_literal: true

require 'json'

class Fetch
  def initialize(profile, region = 'us-east-1')
    @profile = profile
    @region = region
  end

  def get_parameters
    JSON.parse(`aws --profile #{@profile} --region #{@region} \
                ssm describe-parameters`)['Parameters']
  end
end
