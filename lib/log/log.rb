class Log
  include SubjectName

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
    Device.configure(self, subject)
    self
  end

  def call(text, level=nil, tag: nil, tags: nil)
    tags ||= []
    tags = Array(tags)
    tags << tag unless tag.nil?

    message = text
    device.write(message, subject)
    telemetry.record :logged, Telemetry::Data.new(subject_name, text, level, tags)
  end

  def subject_name
    @subject_name ||= self.class.subject_name(subject)
  end

  def self.register_telemetry_sink(writer)
    sink = Telemetry.sink
    writer.telemetry.register sink
    sink
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

  # module Substitute
  #   def self.build
  #     Cycle::None.build.tap do |instance|
  #       sink = Cycle.register_telemetry_sink(instance)
  #       instance.sink = sink
  #     end
  #   end
  # end




  class Substitute < Log
    def self.build
      instance = new('(substitute logger)')
      instance.device = Device::Substitute.build
      instance
    end

    def entries(&predicate)
      predicate ||= -> { true }
      device.entries(&predicate)
    end

    def entry?(&predicate)
      device.entry?(&predicate)
    end
  end
end
