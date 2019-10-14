require_relative '../automated_init'

context "Log" do
  context "Write at a Level that Isn't One of the Logger's Levels" do
    logger = Log::Controls::Log::Levels.example

    unknown_level = :some_other_level

    sink = logger.telemetry_sink

    test "Is an error" do
      assert_raises Log::Error do
        logger.('some message', unknown_level)
      end
    end

    test "Message isn't logged" do
      logged = sink.recorded_logged? do |record|
        record.data.level == unknown_level
      end

      refute(logged)
    end
  end
end
