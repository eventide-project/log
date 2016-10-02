require_relative '../automated_init'

context "Log" do
  context "Device" do
    context "Substitute" do
      logger = Log.new('some_subject')
      logger.('some message')

      test "Messages are recorded" do
        entries = logger.device.entries { |entry| entry.include? 'some message' }
        refute(entries.empty?)
      end

      test "Detect message" do
        detected = logger.device.entry? { |entry| entry.include? 'some message' }
        assert(detected)
      end
    end
  end
end
