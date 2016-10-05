require_relative '../init'
require 'test_bench'; TestBench.activate
require 'pp'

# Default levels and color for default level
# Examples:
#   LOG_LEVEL=data ruby demo/ext_ctrl.rb
#   LOG_LEVEL=_min ruby demo/ext_ctrl.rb
#   LOG_LEVEL=_max ruby demo/ext_ctrl.rb
logger = Log.build('Levels and Colors for Min Level')

logger.level_names.each do |level_name|
  logger.("some #{level_name} message", level_name)
end
