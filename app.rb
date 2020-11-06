#!/usr/local/bin/ruby -w
# frozen_string_literal: true

require 'json'
require 'pp'
require 'colorize'
Dir["./lib/*.rb"].each {|file| require file }

# interface to pull ssm params from one account and push to another
class App
  def initialize(from_profile, to_profile = nil, env = nil, region = 'us-east-1')
    @from_profile = from_profile
    @to_profile = to_profile
    @env = env
    @region = region
  end

  def perform
    Core.new(from_profile, to_profile, source, region, env)
  end

  private

  # gets all SSM Params for this account
  def source
    @source ||= Fetch.new(@from_profile, @region).parameters
  end
end

App.new(*ARGV).perform
# App.new('nac', :foo, 'production').perform
