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

  def device
    @device ||= Defaults.device
  end

  def telemetry
    @telemetry ||= ::Telemetry.build
  end

  def self.build(subject)
    instance = new(subject)
    Clock::UTC.configure(instance)
    set_defaults(instance)
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

  def self.set_defaults(logger)
    logger.class.add_levels(logger)
    logger.level = Defaults.level
    logger.tags = Defaults.tags
  end
end
