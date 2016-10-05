require_relative '../automated_init'

context "Log" do
  context "Logger Level" do
    context "Set to one of the logger's levels" do
      logger = Log::Controls::Log::Levels.example

      control_level = Log::Controls::Log::Levels.middle
      logger.level = control_level
      level = logger.level

      test "Is set to that level" do
        assert(level == control_level)
      end
    end

    context "Set a level that isn't one of the logger's levels" do
      # logger = Log::Controls::Log::Levels.example
      logger = Log.no_defaults('some subject')
      unchanged_level = logger.level

      unknown_level = :some_other_level

      test "Is an error" do
        assert proc { logger.level = unknown_level } do
          raises_error? Log::Error
        end
      end

      test "Logger's level remains unchanged" do
        assert(logger.level == unchanged_level)
      end
    end
  end
end
