class Log
  class Error < RuntimeError; end

  extend Registry
  include Levels
  include Level
  include Tags
  include Filter
  include Write
  include SubjectName
  extend Telemetry::Register

  dependency :clock, Clock::UTC

  initializer :subject

  def io
    @io ||= STDERR
  end

  def telemetry
    @telemetry ||= ::Telemetry.build
  end

  def self.build(subject)
    instance = new(subject)
    Clock::UTC.configure(instance)
    Defaults.set(instance)
    instance
  end

  def self.no_defaults(subject)
    instance = new(subject)
    Clock::UTC.configure(instance)
    instance
  end

  def self.bare(subject)
    no_defaults(subject)
  end

  def self.configure(receiver, attr_name: nil)
    attr_name ||= :logger
    instance = get(receiver)
    receiver.public_send("#{attr_name}=", instance)
    instance
  end

  def call(message, level=nil, tag: nil, tags: nil)
    tags ||= []
    tags = Array(tags)
    tags << tag unless tag.nil?

    assure_level(level)

    if write?(level, tags)
      write(message, level, tags)
    end
  end

  def write?(message_level, message_tags)
    write_level?(message_level) && write_tag?(message_tags)
  end

  def clear
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

    def self.formatters
      {
        fatal: proc { |message| Rainbow(message).white.bg(:black) },
        error: proc { |message| Rainbow(message).red.bg(:black) },
        warn: proc { |message| Rainbow(message).yellow.bg(:black) },
        info: proc { |message| Rainbow(message).green },
        trace: proc { |message| Rainbow(message).white },
        data: proc { |message| Rainbow(message).cyan }
      }
    end

    def self.set(logger)
      Levels::Default.add(logger)
      logger.level = logger.class.level
    end
  end
end
