# frozen_string_literal: true

require 'colorize'
require_relative 'key_values'

# collect source and update target prameters
class Core
  def initialize(from_profile, to_profile, source, region = 'us-east-1', env = nil)
    @from_profile = from_profile
    @to_profile = to_profile
    @source = source
    @region = region
    @env = env
  end

  def perform
    puts 'Collecting data...'.colorize(:light_blue)
    pre_commit_payload reference_data
    puts " Push the #{reference_data.length} key(s) and values listed above? [y/n]".red
    response = $stdin.gets.chomp
    cancel_update(response) if response != 'y'
    push_payload(reference_data)
  end

  private

  # :nocov:
  def push_payload(data)
    Push.new(@to_profile, data).perform
    puts 'Done'.green
  end

  def pre_commit_payload(data)
    data.each do |param|
      puts "key: #{Push.trim_environment(param['Name'], @env)}, value: #{param['Value']}"
    end
  end

  def cancel_update(response)
    puts ('=' * 88).red
    puts " \"#{response.chomp}\" entered, must be Y to continue".red
    puts ' This synch has been cancelled, no parameters have been pushed'.red
    puts ('=' * 88).red
    exit true
  end

  # for each SSM Key retrieve it's value and return an array of hashes
  def reference_data
    @reference_data ||= KeyValues.new(@from_profile, @source).format_data
  end
  # :nocov:
end
