require_relative 'automated_init'

context "Log" do
  context "Default Levels" do
    logger = Log.build('some subject')

    test "Logger's level is info" do
      assert(logger.level == :info)
    end

    context "Level Methods" do
      Log::Defaults.levels.each do |level|
        test "#{level}" do
          assert(logger.respond_to? level)
        end
      end
    end
  end
end
