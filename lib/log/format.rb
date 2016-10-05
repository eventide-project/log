module Log::Format
  def self.line(text, time, subject, level)
    "#{header(time, subject, level)} #{message(text)}"
  end

  def self.message(text)
    text
  end

  def self.header(time, subject, level)
  end
end
