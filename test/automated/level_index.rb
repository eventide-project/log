require_relative 'automated_init'

context "Log" do
  context "Level Index" do
    logger = Log::Controls::Log::Operational.example

    logger.add_level(:higher)
    logger.add_level(:lower)

    logger.level = :higher

    context "Higher precedence level" do
      level_index = logger.level_index(:higher)

      test "Is added earlier" do
        assert(level_index == 0)
      end
    end

    context "Lower precedence level" do
      level_index = logger.level_index(:lower)

      test "Is added later" do
        assert(level_index == 1)
      end
    end

    context "Unknown precedence level" do
      level_index = logger.level_index(:something_else)

      test "Has no level" do
        assert(level_index.nil?)
      end
    end
  end
end
