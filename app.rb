#!/usr/local/bin/ruby -w
# frozen_string_literal: true

require 'json'
require 'pp'

require './lib/fetch.rb'
require './lib/key_values.rb'
require './lib/push.rb'

# interface to pull ssm params from one account and push to another
class App
  def initialize(from_profile, to_profile = :foo, region = 'us-east-1')
    @from_profile = from_profile
    @to_profile = to_profile
    @region = region
  end

  def perform
    Push.new(@to_profile, reference_data).perform
  end

  private

  # for each SSM Key retrieve it's value and return an array of hashes
  def reference_data
    @reference_data ||= KeyValues.new(@from_profile, source).format_data
  end

  # gets all SSM Params for this account
  def source
    @source ||= Fetch.new(@from_profile, @region).parameters
  end
end

App.new('ekv3').perform
