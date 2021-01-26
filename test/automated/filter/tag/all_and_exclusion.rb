require_relative '../../automated_init'

context "Log" do
  context "Filter" do
    context "Tag" do
      context "All and Exclusion" do
        context "Messages with excluded tags" do
          logger = Log::Controls::Log.example
          logger.tags = [:_all, :'-some_other_tag']

          sink = logger.telemetry_sink

          logger.('some other message', tags: [:some_other_tag])

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
