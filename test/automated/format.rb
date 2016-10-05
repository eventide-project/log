require_relative 'automated_init'

context "Log" do
  context "Format" do
    logger = Log::Controls::Log.example
    logger.level = :some_level

    logger.('Some message', :some_level)

    pp logger.telemetry_sink

  end
end
