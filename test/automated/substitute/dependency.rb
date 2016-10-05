require_relative '../automated_init'

context "Log" do
  context "Substitute" do
    context "Dependency" do
      subject = Log::Controls::Subject.example

      logger = subject.logger

      test "Is the logger's substitute" do
        assert(logger.is_a? Log::Substitute::Log)
      end
    end
  end
end
