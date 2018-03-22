class Log
  module Levels
    def self.included(cls)
      cls.extend AddLevels
    end

    def levels
      @levels ||= {}
    end
    alias :logger_levels :levels

    def levels?
      !levels.empty?
    end
    alias :logger_levels? :levels?

    def level_names
      levels.keys.dup
    end

    module AddLevels
      def add_levels(logger)
        Log::Defaults.levels.each do |level|
          logger.add_level(level, &Log::Defaults.level_formatters[level])
        end
      end
    end
  end
end
