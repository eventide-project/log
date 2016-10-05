ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_FORMATTERS'] ||= 'on'
ENV['LOG_LEVEL'] ||= 'data'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

require 'test_bench'; TestBench.activate

require 'pp'
require 'securerandom'

require 'log/controls'
