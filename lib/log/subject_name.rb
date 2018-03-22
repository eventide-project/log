class Log
  module SubjectName
    def subject_name(subject)
      if subject.is_a?(Class) || subject.is_a?(Module)
        name = subject.name
      elsif subject.is_a? String
        name = subject
      elsif subject.is_a? Symbol
        name = subject.to_s
      else
        name = subject.class.name
      end
      name
    end
  end
end
