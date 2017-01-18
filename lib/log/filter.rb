module Log::Filter
  def write_level?(message_level)
    if message_level.nil?
      if logger_level?
        return false
      else
        return true
      end
    end

    precedent?(message_level)
  end

  def precedent?(message_level)
    levels.fetch(message_level).ordinal <= logger_ordinal
  end

  def write_tag?(message_tags)
    message_tags ||= []

    if message_tags.empty? && !logger_tags?
      return true
    end

    if log_all_tags?
      return true
    end

    if message_tags.empty? && log_untagged?
      return true
    end

    if !message_tags.empty? && logger_tags?
      if logger_tags_intersect?(message_tags)
        return true
      end
    end

    false
  end

  def log_all_tags?
    logger_tag?(:_all)
  end

  def log_untagged?
    logger_tag?(:_untagged)
  end

  def tags_intersect?(message_tags)
    if !(message_tags & logger_excluded_tags).empty?
      return false
    end

    !(logger_included_tags & message_tags).empty?
  end
  alias :logger_tags_intersect? :tags_intersect?
end
