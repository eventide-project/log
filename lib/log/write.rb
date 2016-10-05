module Log::Write
  def write(text, level, tags)
    time = clock.iso8601
    p time
    line = Log::Format.line(text, clock.iso8601, subject_name, level)
    io.puts line
    telemetry.record :logged, Log::Telemetry::Data.new(subject_name, text, level, tags, line)
  end
end
