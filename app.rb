#!/usr/local/bin/ruby -w
# frozen_string_literal: true

require 'json'
require 'pp'
require 'colorize'
Dir["./lib/*.rb"].each {|file| require file }

# interface to pull ssm params from one account and push to another
class App
  def initialize(from_profile, to_profile, region = 'us-east-1')
    @from_profile = from_profile
    @to_profile = to_profile
    @region = region
  end

  def perform
    puts "Collecting data...".colorize(:light_blue)
    pre_commit_payload reference_data
    puts " Push the #{reference_data.length} key(s) and values listed above? [Y/N]".red
    cancel_update(gets) if gets.chomp.downcase != 'y'
    push_payload(reference_data)
  end


  private

  def push_payload(data)
    Push.new(@to_profile,data).perform
    puts "Done".green
  end

  def pre_commit_payload(data)
    data.each do |param| 
      puts "key: #{Push.trim_environment(param['Name'])}, value: #{param['Value']}"
    end
  end

  def cancel_update(response)
    puts ("="*88).red
    puts " \"#{response.chomp}\" entered, must be Y to continue".red
    puts " This synch has been cancelled, no parameters have been pushed".red
    puts ("="*88).red
    exit true
  end

  # for each SSM Key retrieve it's value and return an array of hashes
  def reference_data
    @reference_data ||= KeyValues.new(@from_profile, source).format_data
  end

  # gets all SSM Params for this account
  def source
    @source ||= Fetch.new(@from_profile, @region).parameters
  end
end

App.new(*ARGV).perform
