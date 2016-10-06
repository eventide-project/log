require_relative '../init'
require 'test_bench'; TestBench.activate
require 'pp'

logger = Log.build('Telemetry Demo')

logger.level = :info
logger.tag = :some_tag

sink = Log.register_telemetry_sink(logger)

logger.info('some message', tag: :some_tag)

telemetry_data = sink.logged_records.first.data

p telemetry_data.subject_name
# => "Telemetry Demo"

p telemetry_data.message
# => "some message"

p telemetry_data.line
# => "[2000-01-01T00:00:00.00000Z] Telemetry Demo INFO: some message"

p telemetry_data.level
# => :info

puts telemetry_data.tags
# => [:some_tag]
