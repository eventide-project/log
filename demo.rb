require_relative 'init'
require 'test_bench'; TestBench.activate

logger = Log.build('some subject')

logger.add_level :higher_level
logger.add_level :lower_level

logger.level = :higher_level

logger.('some higher message', :higher_level)
# writes

logger.('some lower message', :lower_level)
# doesn't write


logger.level = :lower_level

logger.('some higher message', :higher_level)
# writes

logger.('some lower message', :lower_level)
# writes


assert proc { logger.('some message', :some_unknown_level)} do
 raises_error? Log::Error
end


logger.tag = :some_tag

logger.('some tagged message', tag: :some_tag)
# writes

logger.('some other tagged message', tags: [:some_other_tag, :yet_another_tag])
# doesn't write


logger.tags = [:some_tag, :some_other_tag]

logger.('some tagged message', tag: :some_tag)
# writes

logger.('some other tagged message', tags: [:some_other_tag, :yet_another_tag])
# writes
