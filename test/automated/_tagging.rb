require_relative 'automated_init'

context "Log" do
  context "Tagging" do
    test "Write only tag specified" do
      logger = Log.new

      logger.tag = :some_tag

      logger.('some message', tag: :some_tag)

      test "Messages are recorded" do
        entries = logger.entries { |entry| entry.include? 'some message' }
        refute(entries.empty?)
      end
    end
  end
end
