module Log::Tags
  def tags
    @tags ||= []
  end
  alias :logger_tags :tags

  def tags=(tags)
    if tags.nil?
      @tags = nil
      return
    end
    @tags = Array(tags)
  end

  def tag=(tag)
    self.tags = tag
  end

  def tags?
    !tags.empty?
  end
  alias :logger_tags? :tags?

  def tag?(tag)
    tags.include?(tag)
  end
  alias :logger_tag? :tag?
end
