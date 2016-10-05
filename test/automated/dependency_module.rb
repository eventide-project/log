require_relative 'automated_init'

context "Log" do
  context "Dependency Module" do
    Example = Class.new do
      include Log::Dependency
    end

    obj = Example.new

    test "Adds the logger accessor" do
      assert(obj.respond_to? :logger)
    end

    test "Logs" do
      obj.logger.('some message')
    end
  end
end
