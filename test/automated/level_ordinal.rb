require_relative 'automated_init'

context "Log" do
  context "Level Ordinal" do
    logger = Log::Controls::Log::Operational.example

    logger.add_level(:higher)
    logger.add_level(:lower)

    logger.level = :higher

    context "Higher precedence level" do
      ordinal = logger.ordinal(:higher)

      test "Is added earlier" do
        assert(ordinal == 0)
      end
    end

    context "Lower precedence level" do
      ordinal = logger.ordinal(:lower)

      test "Is added later" do
        assert(ordinal == 1)
      end
    end

    context "Unknown precedence level" do
      ordinal = logger.ordinal(:something_else)

      test "Has no level" do
        assert(ordinal.nil?)
      end
    end
  end
end
