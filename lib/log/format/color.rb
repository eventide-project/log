class Log
  module Format
    module Color
      def self.color?(device)
        device.tty?
      end

      def self.header(text, device)
        return text unless color?(device)
        TerminalColors::Apply.(text, fg: :white)
      end

      def self.message(text, device, **options)
        return text unless color?(device)
        TerminalColors::Apply.(text, **options)
      end
    end
  end
end
