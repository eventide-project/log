module Log::Level
  def level
    @level
  end

  def level=(level)
    assure_level(level)
    @level = level
  end

  def add_level(level)
    return if level?(level)
    Method.define(self, level)
    levels[level] = levels.length
  end

  def remove_level(level)
    return unless level?(level)
    Method.remove(self, level)
    levels.delete(level)
  end

  def assure_level(level)
    unless level.nil? || !levels? || level?(level)
      raise Log::Error, "Level #{level.inspect} must be one of: #{levels.keys.join(', ')}"
    end
  end

  module Method
    def self.define(logger, level_name)
      level = level_name
      logger.define_singleton_method(level) do |message, tag: nil, tags: nil|
        self.(message, level, tag: tag, tags: tags)
      end
    end

    def self.remove(logger, level_name)
      logger.instance_eval "undef #{level_name}"
    end
  end
end
