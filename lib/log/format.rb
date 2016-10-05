module Log::Format
  def self.line(message, time, subject, level, &message_formatter)
    "#{header(time, subject, level)} #{message(message, &message_formatter)}"
  end

  def self.message(message, &message_formatter)
    return message unless block_given?
    message_formatter.(message)
  end

  def self.header(time, subject, level)
    header = "[#{time}] #{subject}"
    unless level.nil?
      header << " #{level.to_s.upcase}"
    end
    header << ':'
    Color.header(header)
  end

  module Defaults
    def self.message_formatter
      proc {|message| message }
    end
  end
end
