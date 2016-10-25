require_relative '../automated_init'

context "Log" do
  context "Write" do
    context "Missing Message" do
      logger = Log::Controls::Log.example

      sink = logger.telemetry_sink

      test "Is an error" do
        assert proc { logger.call } do
          raises_error? ArgumentError
        end
      end
    end
  end
end
