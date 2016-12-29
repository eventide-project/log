require_relative '../../automated_init'

context "Log" do
  context "Filter" do
    context "Tag" do
      context "All" do
        logger = Log::Controls::Log.example

        logger.tags = [:_all]

        sink = logger.telemetry_sink

        context "Messages with tags" do
          logger.('some message', tag: :some_tag)

          logged = sink.recorded_logged? do |record|
            record.data.tags == [:some_tag]
          end

          test "Are logged" do
            assert(logged)
          end
        end

        context "Messages without tags" do
          logger.('some other message')

          logged = sink.recorded_logged? do |record|
            record.data.tags == []
          end

          test "Are logged" do
            assert(logged)
          end
        end
      end
    end
  end
end
