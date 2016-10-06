require_relative 'automated_init'

context "Log" do
  context "Telemetry" do
    context "Logged" do
      logger = Log::Controls::Log.example

      time = Log::Controls::Time::Raw.example
      logger.clock.now = time

      logger.add_level :some_level

      logger.level = :some_level
      logger.tag = :some_tag

      sink = logger.telemetry_sink

      logger.('some message', :some_level, tag: :some_tag)

      telemetry_data = sink.logged_records.first.data

      test "subject_name" do
        assert(telemetry_data.subject_name == logger.subject)
      end

      test "message" do
        assert(telemetry_data.message == 'some message')
      end

      test "line" do
        assert(telemetry_data.line.include? Log::Controls::Time.example(precision: 5))
        assert(telemetry_data.line.include? '(substitute logger)')
        assert(telemetry_data.line.include? 'some message')
        assert(telemetry_data.line.include? 'SOME_LEVEL')
      end

      test "level" do
        assert(telemetry_data.level == :some_level)
      end

      test "tags" do
        assert(telemetry_data.tags == [:some_tag])
      end
    end
  end
end
