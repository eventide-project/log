require_relative '../init'
require 'test_bench'; TestBench.activate
require 'pp'

# # Default levels and color for default level
# logger = Log.build('Levels and Colors for Min Level')

# logger.level_names.each do |level_name|
#   logger.("some #{level_name} message", level_name)
# end


# Default tags
logger = Log.no_defaults('Default Tags Demo')

logger.('some tagged message', tags: [:some_tag, :some_other_tag])
logger.('some other tagged message', tags: [:some_other_tag, :yet_another_tag])
