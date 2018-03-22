class Log
  module Controls
    module Subject
      def self.example
        Example.new
      end

      def self.new
        example
      end

      module Operational
        def self.example
          Subject::Example.build
        end
      end

      class Example
        dependency :logger, ::Log

        def self.build
          instance = new
          ::Log.configure(instance)
          instance
        end
      end
    end
  end
end
