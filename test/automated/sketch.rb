require_relative 'automated_init'

logger = Log.build('some_subject')
logger.('some message')

logger = Log.new('some_subject')
logger.('some message')

p logger.device.entries { |entry| entry.include? 'some message' }
p logger.device.entry? { |entry| entry.include? 'some message' }

pp logger.device
