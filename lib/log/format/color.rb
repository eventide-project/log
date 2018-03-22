class Log
  module Format
    module Color
      def self.header(text)
        TerminalColors::Apply.(text, fg: :white)
      end
    end
  end
end
