class Log
  dependency :device, Device

  initializer :subject

  def self.build(subject=nil)
    subject ||= ''

    instance = new(subject)
    instance.configure

    instance
  end

  ## self.configure

  ## self.get (uses registry) (indexed on device.subject_name)

  def configure
    Device.configure(self, subject)
    self
  end

  def call(message)
    device.write(message, subject)
  end
end
