require_relative '../automated_init'

context "Log" do
  context "Write" do
    context "Block" do
      context "Written" do
        logger = Log::Controls::Log.example

        sink = logger.telemetry_sink

        logger.call { 'some message' }

        logged_message = sink.logged_records.first &.data &.message

        test "Block is converted to text" do
          assert(logged_message == 'some message')
        end
      end

      context "Not Written" do
        logger = Log::Controls::Log.example
        logger.add_level :some_level

        test "Block is not evaluated" do
          refute_raises RuntimeError do
            logger.some_level { fail }
          end
        end
      end
    end
  end
end
