class Log
  class Error < RuntimeError; end

  include SubjectName

  attr_reader :level
  attr_reader :tags

  def level=(level)
    unless level.nil? || levels.has_key?(level)
      raise Error, "Level #{level.inspect} must be one of: #{levels.keys.join(', ')}"
    end
    @level = level
  end

  def levels
    @levels ||= {}
  end

  def level_names
    levels.keys.dup
  end

  def tags=(tags)
    @tags = Array(tags)
  end

  def tag=(tag)
    self.tags = tag
  end

  dependency :device, Device

  def telemetry
    @telemetry ||= ::Telemetry.build
  end

  initializer :subject

  def self.registry
    @registry ||= {}
  end

  def self.build(subject)
    instance = new(subject)
    instance.configure
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

  def configure
    Device.configure(self)
    self
  end

  def call(text, level=nil, tag: nil, tags: nil)
    tags ||= []
    tags = Array(tags)
    tags << tag unless tag.nil?

    if precedent?(level) && tagged?(tags)
      write(text, level, tags)
    end
  end

  def tagged?(tags)
    tagged = true
    unless self.tags.nil?
      if (self.tags & tags).empty?
        tagged = false
      end
    end
    tagged
  end

  def precedent?(level)
    ordinal(level) <= ordinal
  end

  def write(text, level, tags)
    message = text
    device.write(message, subject)
    telemetry_data = Telemetry::Data.new(subject_name, text, level, tags)
    telemetry.record :logged, telemetry_data
  end

  def add_level(level)
    return if level?(level)
    LevelMethod.define(self, level)
    levels[level] = levels.length
  end

  def level?(level)
    levels.has_key?(level)
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

  def self.register_telemetry_sink(writer)
    sink = Telemetry.sink
    writer.telemetry.register sink
    sink
  end

  module LevelMethod
    def self.define(instance, level_name)
      level = level_name
      instance.define_singleton_method(level) do |message, tag: nil, tags: nil|
        self.(message, level, tag: tag, tags: tags)
      end
    end
  end

  module Telemetry
    class Sink
      include ::Telemetry::Sink

      record :logged
    end

    Data = Struct.new :subject_name, :message, :level, :tags

    def self.sink
      Sink.new
    end
  end

  module Substitute
    def self.build
      instance = Log.new('(substitute logger)')
      sink = Log.register_telemetry_sink(instance)
      instance.telemetry_sink = sink
      instance
    end

    class Log < ::Log
      attr_accessor :telemetry_sink
    end
  end
end
