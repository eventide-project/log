class Telemetry
  module Logger
    extend self

    def build(subject, implementation=nil)
      implementation ||= Defaults.implementation
      logger = implementation.build(subject)
      logger
    end

    def get(subject, implementation=nil)
      build(subject, implementation)
    end

    def register(subject, implementation=nil)
      logger = Logger.build self
      logger.obsolete "The \"register\" method is obsolete (#{caller[0]}). It is replaced with the \"build\" method."

      build(subject, implementation)
    end

    def configure(receiver, implementation=nil)
      logger = build(receiver, implementation)
      receiver.logger = logger
      logger
    end

    def self.debug(message)
      write message
    end

    def self.write(message, level=nil, subject=nil, implementation=nil)
      level ||= :debug
      subject ||= '***'

      logger = build subject, implementation

      logger.write_message message, level
    end

    module Defaults
      def self.implementation
        ConsoleLogger
      end
    end
  end
end
