# frozen_string_literal: true

require 'json'

# build source keys from input
class Source
  def initialize
    puts '------------------------------------------------'.colorize(:light_blue)
    puts 'Input comma separated keys to migrate'.colorize(:light_blue)
    puts '------------------------------------------------'.colorize(:light_blue)
    build_source $stdin.gets.chomp
  end

  private

  def build_source(input)
    keys = Array(input.split(',').map(&:strip))
    select_keys = []
    keys.each do |k|
      f = {}
      f['Name'] = k
      select_keys << f
    end
    puts select_keys
    select_keys
  end
end
