require_relative 'automated_init'

context "Log" do
  context "Substitute" do
    subject = Log::Controls::Subject.example

    logger = subject.logger

    logger.('some message')

    test "Messages are recorded" do
      entries = logger.entries { |entry| entry.include? 'some message' }
      refute(entries.empty?)
    end

    test "Detect message" do
      detected = logger.entry? { |entry| entry.include? 'some message' }
      assert(detected)
    end
  end
end
