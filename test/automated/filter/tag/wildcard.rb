require_relative '../../automated_init'

context "Log" do
  context "Filter" do
    context "Tag" do
      context "Wildcard" do
        context "No Logger Tags" do
          logger = Log::Controls::Log.example

          logger.tags = []

          sink = logger.telemetry_sink

          context "Messages with wildcard tag" do
            logger.('some message', tags: [:*, :some_tag])

            logged = sink.recorded_logged? do |record|
              record.data.tags.include?(:*) &&
                record.data.tags.include?(:some_tag)
            end

            test "Are logged" do
              assert(logged)
            end
          end
        end

        context "Logger Has Tags" do
          logger = Log::Controls::Log.example

          logger.tags = [:something]

          sink = logger.telemetry_sink

          context "Messages with wildcard tag" do
            logger.('some message', tags: [:*, :some_tag])

            logged = sink.recorded_logged? do |record|
              record.data.tags.include?(:*) &&
                record.data.tags.include?(:some_tag)
            end

            test "Are logged" do
              assert(logged)
            end
          end
        end
      end
    end
  end
end
