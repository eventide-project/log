require_relative 'automated_init'

context "Log" do
  context "Level Methods" do
    logger = Log::Controls::Log::Levels.example
    logger.level = Log::Controls::Log::Levels.lower

    sink = logger.telemetry_sink

    context "Logger Has an Instance Method for Each Level" do
      logger.level_names.each do |level_name|
        context "#{level_name.inspect}" do

          logger.public_send(level_name, "some #{level_name} message", tags: [:some_tag])

          telemetry_data = sink.logged_records do |record|
            record.data.level == level_name
          end &.first &.data

          test "Message" do
            assert(telemetry_data.message == "some #{level_name} message")
          end

          test "Level" do
            assert(telemetry_data.level == level_name)
          end

          test "Tags" do
            assert(telemetry_data.tags == [:some_tag])
          end
        end
      end
    end
  end
end

