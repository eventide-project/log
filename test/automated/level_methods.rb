require_relative 'automated_init'

context "Log" do
  context "Level Methods" do
    logger = Log::Controls::Log::Levels.example

    context "Logger Has an Instance Method for Each Level" do
      logger.level_names.each do |level_name|
        test "#{level_name}" do
          logger.respond_to?(level_name)
        end
      end
    end
  end
end
