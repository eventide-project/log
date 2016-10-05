module Log::Tags
  def self.included(cls)
    cls.extend ClassDefaults
  end

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

  module ClassDefaults
    def tags
      @tags ||= Log::Defaults.tags
    end

    def tags=(tags)
      @tags = tags
    end
  end
end
