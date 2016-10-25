require_relative '../init'
require 'test_bench'; TestBench.activate
require 'pp'

logger = Log.no_defaults('Logger Demo')
logger.call { 'some message' }

logger.add_level :some_level
logger.level = :some_level

logger.some_level { 'some block message' }

logger.tag = :some_tag
logger.some_level(:tag => :some_tag) { 'some tagged block message' }
