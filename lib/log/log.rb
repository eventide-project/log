class Log
  class Error < RuntimeError; end

  extend DefaultLevels
  extend Registry
  extend Telemetry::Register
  include Level
  include SubjectName

  initializer :subject

  def io
    @io ||= STDERR
  end

  def telemetry
    @telemetry ||= ::Telemetry.build
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

  def self.build(subject)
    instance = new(subject)
    Defaults.set(instance)
    instance
  end

  def self.configure(receiver, attr_name: nil)
    attr_name ||= :logger

    instance = get(receiver)
    receiver.public_send("#{attr_name}=", instance)
    instance
  end

  def call(text, level=nil, tag: nil, tags: nil)
    tags ||= []
    tags = Array(tags)
    tags << tag unless tag.nil?

    assure_level(level)

    if write?(level, tags)
      write(text, level, tags)
    end
  end

  def write?(level, tags)
    ## TODO remove this
    ## write if message level nil and logger level nil
    return false if level.nil? && !self.level.nil?
    precedent?(level) && write_tag?(tags)
  end

  ## filter concern
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

  ## tag concern
  def tag?(tag)
    tags.include?(tag)
  end
  alias :logger_tag? :tag?


  def write(text, level, tags)
    message = text
    io.puts "#{subject_name} #{message}"
    telemetry.record :logged, Telemetry::Data.new(subject_name, text, level, tags)
  end


  def reset
    level_names.each do |level_name|
      remove_level(level_name)
    end
    self.level = nil
  end

  module Defaults
    def self.level
      :info
    end

    def self.levels
      [
        :fatal,
        :error,
        :warn,
        :info,
        :debug,
        :trace,
        :data
      ]
    end

    def self.set(logger)
      DefaultLevels.add(logger)
      logger.level = logger.class.level
    end
  end
end
