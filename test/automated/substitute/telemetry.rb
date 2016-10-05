require_relative '../automated_init'

context "Log" do
  context "Substitute" do
    context "Telemetry" do
      logger = Log::Substitute.build

      logger.info('some message')

      records = logger.telemetry_sink.logged_records

      test "Logged telemetry is recorded" do
        refute(records.empty?)
      end
    end
  end
end
