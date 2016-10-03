class Log
  module Dependency
    def self.included(cls)
      cls.class_exec do
        dependency :logger, Log

        def logger
          pp self.class.name
          @logger ||= Log.configure self
        end
      end
    end
  end
end
