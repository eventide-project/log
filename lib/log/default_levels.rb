module Log::DefaultLevels
  def levels
    @levels ||= Log::Defaults.levels
  end

  def levels=(levels)
    @levels = levels
  end

  def reset
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

