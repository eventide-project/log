module Log::Write
  def write(message, level, tags)
    message = message.to_s

    if message.length == 0
      message = '(empty log message)'
    end

    line = Log::Format.line(message, clock.iso8601(precision: 5), subject, level, &levels[level] &.message_formatter)

    device.puts line

    telemetry.record :logged, Log::Telemetry::Data.new(subject, message, level, tags, line)
  end
end
