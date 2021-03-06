#!/usr/local/bin/ruby -w
# frozen_string_literal: true

require 'json'
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
    Core.new(@from_profile, @to_profile, source, {region: region, env: env})
  end

  # gets all SSM Params for this account
  def source
    puts '------------------------------------------------'.colorize(:light_blue)
    puts 'Input keys? [y/n]'.colorize(:light_blue)
    puts '------------------------------------------------'.colorize(:light_blue)
    $stdin.gets.chomp == 'y' ? source_keys : all_keys
  end

  private

  def all_keys
    @source ||= Fetch.new(@from_profile, @region).parameters
  end

  def source_keys
    Source.new
  end
end

App.new(*ARGV).perform
# App.new('nac', :foo, 'production').perform
