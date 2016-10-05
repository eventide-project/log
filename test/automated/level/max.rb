require_relative '../automated_init'

context "Log" do
  context "Logger Level" do
    context "Set to the Maximum Level" do
      logger = Log::Controls::Log::Levels.example

      control_level = Log::Controls::Log::Levels.lower

      logger.level = :_max

      level = logger.level

      test "Is set to that level" do
        assert(level == control_level)
      end
    end
  end
end
