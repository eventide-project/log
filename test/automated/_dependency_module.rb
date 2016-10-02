require_relative 'bench_init'

context "Dependency Module" do
  DependencyModule = Class.new do
    include Telemetry::Logger::Dependency
  end

  obj = DependencyModule.new

  test "Adds the logger accessor" do
    assert(obj.respond_to? :logger)
  end

  test "Logs" do
    obj.logger.pass "Logs"
  end
end
