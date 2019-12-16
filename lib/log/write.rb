class Log
  module Write
    def write(message, level, tags)
      message = message.to_s

      if message.length == 0
        message = '(empty log message)'
      end

      line = Log::Format.line(message, clock.iso8601(precision: 5), subject, level, device, &levels[level] &.message_formatter)

      puts "#{line}#{$INPUT_RECORD_SEPARATOR}"

      telemetry.record :logged, Log::Telemetry::Data.new(subject, message, level, tags, line)
    end

    def puts(message)
      device.write(message)
    end
  end
end
