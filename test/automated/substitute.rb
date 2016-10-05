require_relative 'automated_init'

context "Log" do
  context "Substitute" do
    subject = Log::Controls::Subject.example

    logger = subject.logger

    logger.('some message')

    records = logger.telemetry_sink.logged_records

    test "Logged telemetry is recorded" do
      refute(records.empty?)
    end
  end
end
