class Log
  class Device
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

    def self.subject_name(subject)
      if subject.is_a?(Class) || subject.is_a?(Module)
        name = subject.name
      elsif subject.is_a? String
        name = subject
      else
        name = subject.class.name
      end
      name
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
