module Log::Defaults
  def self.level
    env_level = ENV['LOG_LEVEL']
    return env_level.to_sym if !env_level.nil?

    :info
  end

  def self.tags
    env_tags = ENV['LOG_TAGS']

    return [] if env_tags.nil?

    tags = env_tags.split(',')

    tags.map { |tag| tag.to_sym }
  end

  def self.device
    env_device = ENV['CONSOLE_DEVICE']

    device = nil

    if !env_device.nil?
      if !['stderr', 'stdout'].include?(env_device)
        raise "The CONSOLE_DEVICE should be either 'stderr' (default) or 'stdout'"
      else
        device = (env_device == 'stderr' ? STDERR : STDOUT)
      end
    else
      device = STDERR
    end

    device
  end

  def self.formatters
    env_formatters = ENV['LOG_FORMATTERS']

    if env_formatters.nil?
      env_formatters = :on
    end

    env_formatters.to_sym
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

  def self.level_formatters
    {
      fatal: proc { |message| Rainbow(message).white.bg(:black) },
      error: proc { |message| Rainbow(message).red.bg(:black) },
      warn: proc { |message| Rainbow(message).yellow.bg(:black) },
      info: proc { |message| Rainbow(message).green },
      trace: proc { |message| Rainbow(message).white },
      data: proc { |message| Rainbow(message).cyan }
    }
  end
end
