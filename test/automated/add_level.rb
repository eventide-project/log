require_relative 'automated_init'

context "Log" do
  context "Add Level" do
    logger = Log.no_defaults('some subject')

    level = logger.add_level :some_level, &(proc { |message| message.upcase })

    test "name" do
      assert(level.name == :some_level)
    end

    test "ordinal" do
      assert(level.ordinal == 0)
    end

    test "message_formatter" do
      formatted_message = level.message_formatter.('some message')
      assert(formatted_message == 'SOME MESSAGE')
    end

    context "No Message Formatter" do
      logger = Log.no_defaults('some subject')

      level = logger.add_level :some_level

      context "message_formatter" do
        formatted_message = level.message_formatter.('some message')

        test "Is the default message_formatter" do
          assert(formatted_message == 'some message')
        end
      end
    end
  end
end
