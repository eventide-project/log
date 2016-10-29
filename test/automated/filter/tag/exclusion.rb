require_relative '../../automated_init'

context "Log" do
  context "Filter" do
    context "Tag" do
      context "Exclude" do
        context "Messages with tags matching the logger's tag" do
          logger = Log::Controls::Log.example
          logger.tags = [:some_tag, :'-some_other_tag']

          sink = logger.telemetry_sink

          logger.('some message', tag: :some_tag)

          logged = sink.recorded_logged? do |record|
            record.data.tags == [:some_tag]
          end

          test "Are logged" do
            assert(logged)
          end
        end

        context "Messages with excluded tags" do
          logger = Log::Controls::Log.example
          logger.tags = [:some_tag, :'-some_other_tag']

          sink = logger.telemetry_sink

          logger.('some other message', tags: [:some_tag, :some_other_tag])

          logged = sink.recorded_logged? do |record|
            record.data.tags.include? :some_other_tag
          end

          test "Are not logged" do
            refute(logged)
          end
        end
      end
    end
  end
end
