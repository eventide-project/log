require_relative 'automated_init'

context "Log" do
  context "Precedence" do
    logger = Log::Controls::Log::Levels.example

    mid_point = logger.levels.length / 2

    logger.level = logger.levels.keys[mid_point]

    logger.('some message', logger.levels.keys.first)
    logger.('some other message', logger.levels.keys[mid_point])
    logger.('yet another message', logger.levels.keys.last)

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
