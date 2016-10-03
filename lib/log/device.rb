class Log
  class Device
    include SubjectName

    initializer :subject, :io

    def self.build(subject, io=nil)
      io ||= STDERR
      new(subject, io)
    end

    def self.configure(receiver, subject, attr_name: nil)
      attr_name ||= :device

      subject_name = subject_name(subject)

      instance = build(subject_name)
      receiver.public_send("#{attr_name}=", instance)
      instance
    end

    def write(message, subject=nil)
      subject = "#{subject} " || ''
      io << "#{subject}#{message}\n"
    end

    class Substitute < Device
      def self.build
        new('(substitute device)', [])
      end

      def entries(&predicate)
        predicate ||= -> { true }
        io.select(&predicate)
      end

      def entry?(&predicate)
        io.any?(&predicate)
      end
    end
  end
end
