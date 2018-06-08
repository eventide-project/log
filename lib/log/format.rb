class Log
  module Format
    def self.line(message, time, subject, level, device, &message_formatter)
      header = nil
      if Defaults.header == :on
        header = "#{header(time, subject, level, device)} "
      end

      "#{header}#{message(message, device, &message_formatter)}"
    end

    def self.message(message, device, &message_formatter)
      return message unless block_given?
      if Log::Defaults.formatters == :on
        return message_formatter.(message, device)
      else
        return message
      end
    end

    def self.header(time, subject, level, device)
      header = "[#{time}] #{subject}"
      unless level.nil?
        header << " #{level.to_s.upcase}"
      end
      header << ':'
      Color.header(header, device)
    end

    module Defaults
      def self.message_formatter
        proc {|message| message }
      end

      def self.header
        env_header = ENV['LOG_HEADER']

        if env_header.nil?
          env_header = :on
        end

        env_header.to_sym
      end
    end
  end
end
