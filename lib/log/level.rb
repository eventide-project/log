module Log::Level
  LevelInfo = Struct.new(:name, :ordinal, :message_formatter)

  attr_writer :logger_ordinal

  def level
    @level
  end
  alias :logger_level :level

  def level=(level)
    if [:_min, :_max].include?(level)
      if level == :_min
        level = min_level
      else
        level = max_level
      end
    end

    assure_level(level)
    @level = level

    set_logger_ordinal

    level
  end
  alias :logger_level= :level=

  def level?(level=nil)
    if level.nil?
      !logger_level.nil?
    else
      levels.has_key?(level)
    end
  end
  alias :logger_level? :level?

  def add_level(level, &message_formatter)
    return nil if logger_level?(level)

    Method.define(self, level)

    message_formatter = Log::Format::Defaults.message_formatter unless block_given?

    levels[level] = LevelInfo.new(level, levels.length, message_formatter)
  end

  def remove_level(level)
    return nil unless logger_level?(level)
    Method.remove(self, level)
    levels.delete(level)
  end

  def assure_level(level)
    return if levels.key? level

    if level.nil?
      return
    end

    unless level == :_none
      if !levels?
        raise Log::Error, "Level #{level.inspect} cannot be set. The logger has no levels."
      end

      if !level?(level)
        raise Log::Error, "Level #{level.inspect} must be one of: #{levels.keys.join(', ')}"
      end
    end
  end

  def ordinal(level=nil)
    level ||= logger_level

    if level == :_none
      return -1
    end

    level = levels[level]
    return no_ordinal if level.nil?
    level.ordinal
  end

  def logger_ordinal
    @logger_ordinal ||= set_logger_ordinal
  end

  def set_logger_ordinal
    self.logger_ordinal = ordinal
  end

  def no_ordinal
    -1
  end

  def max_level
    logger_levels.keys.last
  end

  def min_level
    logger_levels.keys.first
  end

  def max_level!
    self.logger_level = max_level
  end

  def min_level!
    self.logger_level = min_level
  end

  def no_level!
    self.logger_level = nil
  end

  module Method
    def self.define(logger, level_name)
      level = level_name
      logger.define_singleton_method(level) do |message=nil, tag: nil, tags: nil, &blk|
        self.(message, level, tag: tag, tags: tags, &blk)
      end
    end

    def self.remove(logger, level_name)
      logger.instance_eval "undef #{level_name}"
    end
  end
end
