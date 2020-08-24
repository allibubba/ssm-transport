#!/usr/local/bin/ruby -w
# frozen_string_literal: true

require 'json'

require './lib/fetch.rb'
require './lib/key_values.rb'

class App
  def initialize(from_profile, region = 'us-east-1')
    @from_profile = from_profile
    @region = region
  end

  def perform
    retrieve_values
  end

  private

  def retrieve_values
    # @retrieve_values ||= KeyValues.new(@from_profile, source).perform
    @retrieve_values ||= KeyValues.new(@from_profile, source)
  end

  def source
    @source ||= Fetch.new(@from_profile, @region).get_parameters
  end
end

