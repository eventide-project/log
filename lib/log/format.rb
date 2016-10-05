module Log::Format
  def self.line(message, time, subject, level, &message_formatter)
    "#{header(time, subject, level)}: #{message(message, &message_formatter)}"
  end

  def self.message(message, &message_formatter)
    return message unless block_given?
    message_formatter.(message)
  end

  def self.header(time, subject, level)
    if level.nil?
      "[#{time}] #{subject}"
    else
      "[#{time}] #{subject} #{level.to_s.upcase}"
    end
  end

  module Defaults
    def self.message_formatter
      proc {|message| message }
    end
  end
end
