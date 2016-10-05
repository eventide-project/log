module Log::Filter
  def precedent?(level)
    ordinal(level) <= ordinal
  end

  def write_tag?(message_tags)
    message_tags ||= []

    if message_tags.empty? && !logger_tags?
      return true
    end

    if !message_tags.empty? && log_all_tags?
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
    !(logger_tags & message_tags).empty?
  end
  alias :logger_tags_intersect? :tags_intersect?
end
