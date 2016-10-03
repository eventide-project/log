require_relative 'automated_init'

context "Log" do
  context "Telemetry" do
    context "Logged" do
      log = Log.new('some subject')
      sink = Log.register_telemetry_sink(log)

      log.('some message', :some_level, tag: :some_tag)

      telemetry_data = sink.logged_records.first.data

      test "subject_name" do
        assert(telemetry_data.subject_name == 'some subject')
      end

      test "message" do
        assert(telemetry_data.message == 'some message')
      end

      test "level" do
        assert(telemetry_data.level == :some_level)
      end

      test "level" do
        assert(telemetry_data.tags == [:some_tag])
      end
    end
  end
end
