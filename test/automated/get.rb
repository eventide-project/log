require_relative 'automated_init'

context "Log" do
  context "Get" do
    logger_1 = Log.get(self)
    logger_2 = Log.get(self)

    context "Registry" do
      test "Identical subjects receive the same logger instance" do
        assert(logger_1.object_id == logger_2.object_id)
      end
    end
  end
end
