require_relative 'automated_init'

context "Log" do
  context "Configure" do
    context "Registration" do
      subject_1 = Log::Controls::Subject::Operational.example
      subject_2 = Log::Controls::Subject::Operational.example

      test "Identical subjects receive the same logger instance" do
        assert(subject_1.logger.object_id == subject_2.logger.object_id)
      end
    end
  end
end
