class Log
  module Write
    def write(message, level, tags)
      message = message.to_s

      if message.length == 0
        message = '(empty log message)'
      end

      line = Log::Format.line(message, clock.iso8601(precision: 5), subject, level, device, &levels[level] &.message_formatter)

      puts "#{line}#{Write.newline_character}"

      telemetry.record :logged, Log::Telemetry::Data.new(subject, message, level, tags, line)
    end

    def puts(message)
      device.write(message)
    end

    def self.newline_character
      @newline_character ||= StringIO.new.tap { |io| io.puts('') }.string
    end
  end
end
