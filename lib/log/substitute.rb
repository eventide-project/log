module Log::Substitute
  def self.build
    instance = Log.build(subject)
    sink = Log.register_telemetry_sink(instance)
    instance.telemetry_sink = sink
    instance
  end

  def self.subject
    '(substitute logger)'
  end

  class Log < ::Log
    attr_accessor :telemetry_sink

    def device
      @device ||= NullDevice
    end

    class NullDevice
      def self.puts(*)
      end
    end
  end
end
