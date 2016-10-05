require_relative '../init'
require 'test_bench'; TestBench.activate
require 'pp'

# Default tags
# Examples:
#   LOG_TAGS=some_tag ruby demo/ext_ctrl.rb
#   LOG_TAGS=some_other_tag ruby demo/ext_ctrl.rb
#   LOG_TAGS=some_tag,yet_another_tag ruby demo/ext_ctrl.rb
#   LOG_TAGS=_untagged ruby demo/ext_ctrl.rb
#   LOG_TAGS=_all ruby demo/ext_ctrl.rb
#   LOG_TAGS=_untagged,_all ruby demo/ext_ctrl.rb
#   LOG_TAGS=_untagged,_all ruby demo/ext_ctrl.rb
logger = Log.build('Default Tags Demo')

logger.no_level!

logger.('some tagged message', tags: [:some_tag, :some_other_tag])
logger.('some other tagged message', tags: [:some_other_tag, :yet_another_tag])
