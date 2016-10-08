require_relative 'automated_init'

context "Log" do
  context "Specialize Tags" do
    logger = Log::Controls::Log::Specialized.example

    sink = logger.telemetry_sink

    logger.info('some message')

    context "Messages" do
      logged = sink.recorded_logged? do |record|
        record.data.tags == [:some_additional_tag]
      end

      telemetry_data = sink.logged_records.first.data
      recorded_tags = telemetry_data &.tags

      test "Are given the specialized logger's tag" do
        assert(recorded_tags.include? :some_additional_tag)
      end
    end
  end
end
