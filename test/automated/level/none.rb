require_relative '../automated_init'

context "Log" do
  context "Logger Level" do
    context "Set to the _none level" do
      logger = Log::Controls::Log::Levels.example

      logger.level = :_none

      sink = logger.telemetry_sink

      context "No level writes a message" do
        logger.level_names.each do |level_name|
          context "#{level_name.inspect}" do
            logger.public_send(level_name, "some #{level_name} message")

            logged = sink.recorded_logged? do |record|
              record.data.level == level_name
            end

            refute(logged)
          end
        end
      end
    end
  end
end
