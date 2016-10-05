require_relative '../automated_init'

# does substitute have default level methods?


context "Log" do
  context "Reset" do
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
