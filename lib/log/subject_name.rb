module Log::SubjectName
  def self.included(cls)
    cls.extend self
  end

  def subject_name(subject)
    if subject.is_a?(Class) || subject.is_a?(Module)
      name = subject.name
    elsif subject.is_a? String
      name = subject
    else
      name = subject.class.name
    end
    name
  end
end
