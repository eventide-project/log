require_relative 'init'
require 'test_bench'; TestBench.activate

logger = Log.build('levels demo')

logger.add_level :higher_level
logger.add_level :lower_level

# Level methods (each level added generates its own corresponding method on the logger)
logger.higher_level 'some higher message'
logger.lower_level 'some higher message'

# Logger actuator
logger.('some higher message', :higher_level)
logger.('some lower message', :lower_level)

logger.('some unleveled message')


# Unknown level
assert proc { logger.('some message', :some_unknown_level) } do
 raises_error? Log::Error
end


# Set logger level
# Log entries with a lower level of precedence are not written
logger.level = :higher_level

# Unknown logger level
assert proc { logger.level = :some_unknown_level } do
 raises_error? Log::Error
end


logger.higher_level 'some higher message'
# writes

logger.lower_level 'some lower message'
# doesn't write

logger.('some unleveled message')
# doesn't write because it's logged at the nil level, which has the lowest precedence

logger.level = :lower_level

logger.higher_level 'some higher message'
# writes

logger.lower_level 'some lower message'
# writes


logger = Log.build('tags demo')

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


logger = Log.build('tags demo')

logger.add_level :higher_level
logger.add_level :lower_level

# Levels and tags together
logger.level = :higher_level
logger.tag = :some_tag

logger.higher_level 'some higher tagged message', tag: :some_other_tag
# Doesn't write because of tags

logger.lower_level 'some lower tagged message', tag: :some_tag
# Doesn't write because of level
