require_relative 'automated_init'

context "Log" do
  context "Precedence" do
    logger = Log::Controls::Log::Levels.example

    logger.level = Log::Controls::Log::Levels.middle

    logger.('some message', Log::Controls::Log::Levels.higher)
    logger.('some other message', Log::Controls::Log::Levels.middle)
    logger.('yet another message', Log::Controls::Log::Levels.lower)

    sink = logger.telemetry_sink

    context "Messages with the same precedence as the logger" do
      logged = sink.recorded_logged? do |record|
        record.data.level == :middle
      end

      test "Are logged" do
        assert(logged)
      end
    end

    context "Messages with higher precedence than the logger" do
      logged = sink.recorded_logged? do |record|
        record.data.level == :higher
      end

      test "Are logged" do
        assert(logged)
      end
    end

    context "Messages with lower precedence than the logger" do
      logged = sink.recorded_logged? do |record|
        record.data.level == :lower
      end

      test "Are not logged" do
        refute(logged)
      end
    end
  end
end
