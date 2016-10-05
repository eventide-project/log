require_relative 'automated_init'

context "Log" do
  context "Format" do
    logger = Log::Controls::Log.example
    logger.level = :some_level

    time = Clock::UTC.now
    logger.clock.now = time

    logger.('Some message', :some_level)

    sink = logger.telemetry_sink

    telemetry_data = sink.logged_records.first.data

    pp telemetry_data

    context "Line" do
      line = telemetry_data.line
      p line

      context "Header" do
        iso_time = Clock::UTC.iso8601(time)

        test "Time" do
          assert(line.include? "[#{iso_time}]")
        end
        test "Subject"
        test "Level"
      end

      test "Message"
    end
  end
end
