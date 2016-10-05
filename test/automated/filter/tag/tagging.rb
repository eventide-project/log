require_relative '../../automated_init'

context "Log" do
  context "Tagging" do
    logger = Log::Substitute.build

    logger.tag = :some_tag

    sink = logger.telemetry_sink

    context "Messages with tags matching the logger's tag" do
      logger.('some message', tag: :some_tag)

      logged = sink.recorded_logged? do |record|
        record.data.tags == [:some_tag]
      end

      test "Are logged" do
        assert(logged)
      end
    end

    context "Messages without tags matching the logger's tag" do
      logger.('some other message', tag: :some_other_tag)

      logged = sink.recorded_logged? do |record|
        record.data.tags == [:some_other_tag]
      end

      test "Are not logged" do
        refute(logged)
      end
    end
  end
end
