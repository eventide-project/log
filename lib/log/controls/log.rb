module Log::Controls
  module Log
    def self.example
      example = ::Log::Substitute::Log.new(::Log::Substitute.subject)

      sink = ::Log.register_telemetry_sink(example)
      example.telemetry_sink = sink

      example
    end

    module Levels
      def self.example
        logger = Log.example
        logger.add_level(higher)
        logger.add_level(middle)
        logger.add_level(lower)
        logger
      end

      def self.higher
        :higher
      end

      def self.middle
        :middle
      end

      def self.lower
        :lower
      end
    end

    module Operational
      def self.example
        ::Log.build(subject)
      end

      def self.subject
        'some subject'
      end
    end
  end
end
