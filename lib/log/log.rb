class Log
  class Error < RuntimeError; end

  extend DefaultLevels
  extend Telemetry::Register
  include SubjectName

  attr_reader :level
  # attr_reader :tags

  def level=(level)
    assure_level(level)
    @level = level
  end

  def levels
    @levels ||= {}
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

  def io
    @io ||= STDERR
  end

  def telemetry
    @telemetry ||= ::Telemetry.build
  end

  initializer :subject

  def self.registry
    @registry ||= {}
  end

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

  def self.get(subject)
    register(subject)
  end

  def self.register(subject)
    subject_name = subject_name(subject)

    instance = registry[subject_name]

    if instance.nil?
      instance = build(subject)
      registry[subject_name] = instance
    end

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
    return false if level.nil? && !self.level.nil?
    precedent?(level) && write_tag?(tags)
  end

  def assure_level(level)
    unless level.nil? || !levels? || level?(level)
      raise Error, "Level #{level.inspect} must be one of: #{levels.keys.join(', ')}"
    end
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

  ## level concern
  def precedent?(level)
    ordinal(level) <= ordinal
  end

  def write(text, level, tags)
    message = text
    io.puts "#{subject_name} #{message}"
    telemetry.record :logged, Telemetry::Data.new(subject_name, text, level, tags)
  end

  def add_level(level)
    return if level?(level)
    LevelMethod.define(self, level)
    levels[level] = levels.length
  end

  def remove_level(level)
    return unless level?(level)
    LevelMethod.remove(self, level)
    levels.delete(level)
  end

  def reset
    level_names.each do |level_name|
      remove_level(level_name)
    end
    self.level = nil
  end

  def level?(level)
    levels.has_key?(level)
  end

  def levels?
    !levels.empty?
  end

  def ordinal(level=nil)
    level ||= self.level
    levels.fetch(level, no_ordinal)
  end

  def no_ordinal
    -1
  end

  def subject_name
    @subject_name ||= self.class.subject_name(subject)
  end

  module LevelMethod
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
