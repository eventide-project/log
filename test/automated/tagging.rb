require_relative 'automated_init'

context "Log" do
  context "Tagging" do
    logger = Log::Substitute.build

    logger.tag = :some_tag

    logger.('some message', :some_level, tag: :some_tag)
    logger.('some other message', :some_level, tag: :some_other_tag)

    sink = logger.telemetry_sink

    context "Messages with tags matching the logger's tag" do
      logged = sink.recorded_logged? do |record|
        record.data.tags == [:some_tag]
      end

      test "Are logged" do
        assert(logged)
      end
    end

    context "Messages without tags matching the logger's tag" do
      logged = sink.recorded_logged? do |record|
        record.data.tags == [:some_other_tag]
      end

      test "Are not logged" do
        refute(logged)
      end
    end
  end
end
