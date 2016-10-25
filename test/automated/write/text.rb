require_relative '../automated_init'

context "Log" do
  context "Write" do
    context "Text" do
      logger = Log::Controls::Log.example

      sink = logger.telemetry_sink

      logger.('some message')

      logged_message = sink.logged_records.first &.data &.message

      test "Text message is written" do
        assert(logged_message == 'some message')
      end
    end
  end
end
