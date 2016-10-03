class Log
  class Device
    include SubjectName

    initializer :io

    def self.build(io=nil)
      io ||= STDERR
      new(io)
    end

    def self.configure(receiver, attr_name: nil)
      attr_name ||= :device

      instance = build
      receiver.public_send("#{attr_name}=", instance)
      instance
    end

    def write(message, subject)
      subject_name = subject_name(subject)
      io << "#{subject_name} #{message}\n"
    end
  end
end
