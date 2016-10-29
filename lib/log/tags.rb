module Log::Tags
  def tags
    @tags ||= []
  end
  alias :logger_tags :tags

  def included_tags
    @included_tags ||= []
  end
  alias :logger_included_tags :included_tags

  def excluded_tags
    @excluded_tags ||= []
  end
  alias :logger_excluded_tags :excluded_tags

  def tags=(tags)
    if tags.nil?
      @tags = nil
      return
    end

    tags = Array(tags)

    tags.each do |tag|
      unless tag.to_s.start_with?('-')
        included_tags << tag
      else
        excluded_tags << tag[1..-1].to_sym
      end
    end

    @tags = tags
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
