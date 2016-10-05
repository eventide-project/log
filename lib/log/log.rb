class Log
  class Error < RuntimeError; end

  extend Registry
  include Levels
  include Level
  include Tags
  include Filter
  include SubjectName
  extend Telemetry::Register

  initializer :subject

  def io
    @io ||= STDERR
  end

  def telemetry
    @telemetry ||= ::Telemetry.build
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
      Levels::Default.add(logger)
      logger.level = logger.class.level
    end
  end
end
