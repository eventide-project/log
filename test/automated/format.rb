require_relative 'automated_init'

context "Log" do
  context "Format" do
    logger = Log::Controls::Log.example
    logger.add_level :some_level
    logger.level = :some_level

    time = Clock::UTC.now
    logger.clock.now = time

    logger.('Some message', :some_level)

    sink = logger.telemetry_sink

    telemetry_data = sink.logged_records.first.data

    context "Line" do
      line = telemetry_data.line

      context "Header" do
        iso_time = Clock::UTC.iso8601(time, precision: 5)

        test "Time" do
          assert(line.include? "[#{iso_time}]")
        end

        test "Subject" do
          assert(line.include? logger.subject_name)
        end

        test "Level" do
          assert(line.include? 'SOME_LEVEL')
        end
      end

      test "Message" do
        assert(line.include? 'Some message')
      end
    end
  end
end
