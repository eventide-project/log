module Log::Levels
  def self.included(cls)
    cls.extend Default
  end

  def levels
    @levels ||= {}
  end

  def levels?
    !levels.empty?
  end

  def level_names
    levels.keys.dup
  end

  module Default
    def levels
      @levels ||= Log::Defaults.levels
    end

    def levels=(levels)
      @levels = levels
    end

    def clear
      @levels = []
      @level = nil
    end

    def level
      @level ||= Log::Defaults.level
    end

    def level=(level)
      @level = level
    end

    def self.add(logger)
      logger.class.levels.each do |level|
        logger.add_level(level)
      end
    end
  end
end
