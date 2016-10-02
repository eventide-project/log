class Telemetry
  module Logger
    module Dependency
      def self.included(cls)
        cls.class_exec do
          dependency :logger, Telemetry::Logger

          def logger
            @logger ||= Logger.configure self
          end
        end
      end
    end
  end
end
