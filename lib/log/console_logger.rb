class Telemetry
  module Logger
    class ConsoleLogger
      include Levels

      attr_reader :name
      attr_reader :device

      attr_reader :level
      attr_reader :level_number

      dependency :clock, Clock::Local

      def self.build(subject)
        name = logger_name(subject)
        device = Defaults.device
        instance = new(name, device)
        instance.level = Defaults.level
        Clock::Local.configure instance
        instance
      end

      def self.logger_name(subject)
        if subject.is_a?(Class) || subject.is_a?(Module)
          name = subject.name
        elsif subject.is_a? String
          name = subject
        else
          name = subject.class.name
        end
        name
      end

      def initialize(name, device)
        @name = name
        @device = device
      end

      def write(message)
        return if Defaults.activation == 'off'
        device.puts message
      end

      def format(message, level)
        return message if Defaults.color == 'off'
        Telemetry::Logger::Color.apply(level, message)
      end

      def format_metadata(text)
        return text if Defaults.color == 'off'
        Telemetry::Logger::Color.metadata(text)
      end

      def level=(level)
        index = ordinal(level)

        raise "Unknown logger level: #{level}" unless index

        @level_number = index
        @level = level
      end

      module Defaults
        def self.level
          level = ENV['LOG_LEVEL']
          return level.to_sym if level

          :info
        end

        def self.device
          setting = ENV['CONSOLE_DEVICE']
          device = nil
          if setting && !['stderr', 'stdout'].include?(setting)
            raise "The CONSOLE_DEVICE should be either 'stderr' (default) or 'stdout'"
          elsif setting
            device = setting == 'stderr' ? STDERR : STDOUT
          else
            device = STDERR
          end
          device.sync = true
          device
        end

        def self.activation
          activation = ENV['LOGGER']
          return activation if activation

          'on'
        end

        def self.color
          color = ENV['LOG_COLOR']

          # CONSOLE_COLOR is obsolete. It is here for backwards compatibility
          if color.nil?
            color = ENV['CONSOLE_COLOR']

            unless color.nil?
              puts '*** WARNING: The CONSOLE_COLOR environment variable is obsolete. Use LOG_COLOR instead. Support for CONSOLE_COLOR will be discontinued.'
            end
          end

          return color if color

          if device.tty?
            'on'
          else
            'off'
          end
        end
      end
    end
  end
end
