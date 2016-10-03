class Log
  module Dependency
    def self.included(cls)
      cls.class_exec do
        dependency :logger, Log

        def logger
          @logger ||= Log.configure self
        end
      end
    end
  end
end
