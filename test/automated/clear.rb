require_relative 'automated_init'

context "Log" do
  context "Clear" do
    logger = Log::Controls::Log.example

    logger.add_level(:higher)
    logger.add_level(:lower)

    logger.level = :higher

    assert(logger.levels.length == 2)

    logger.clear

    test "Logger has no levels" do
      assert(logger.levels.empty?)
    end

    test "Logger's level is not set" do
      assert(logger.level.nil?)
    end

    context "Level Methods are Removed" do
      test "higher" do
        refute(logger.respond_to? :higher)
      end

      test "lower" do
        refute(logger.respond_to? :lower)
      end
    end
  end
end
