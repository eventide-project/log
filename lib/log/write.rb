module Log::Write
  def write(message, level, tags)
    line = Log::Format.line(message, clock.iso8601(precision: 5), subject_name, level, &levels[level] &.message_formatter)
    io.puts line
    telemetry.record :logged, Log::Telemetry::Data.new(subject_name, message, level, tags, line)
  end
end
