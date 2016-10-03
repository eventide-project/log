class Log
  include SubjectName

  dependency :device, Device

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

  def call(message)
    device.write(message, subject)
  end

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
