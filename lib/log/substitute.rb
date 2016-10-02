class Telemetry
  module Logger
    class NullLogger
      include Levels
    end

    module Substitute
      def self.build
        cls = Naught.build do |config|
          config.singleton
          config.mimic NullLogger
        end

        cls.get
      end
    end
  end
end
