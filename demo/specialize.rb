require_relative '../init'
require 'test_bench'; TestBench.activate
require 'pp'

class SpecializedLogger < Log
  def self.tag!(tags)
    tags << :some_tag
  end
end

class SomeSubject
  attr_accessor :logger
end

s = SomeSubject.new

SpecializedLogger.configure s

logger = s.logger


s.logger.info 'Some message'

