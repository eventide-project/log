module Log::SubjectName
  def self.included(cls)
    cls.extend self
  end

  def subject_name(subject)
    if subject.is_a?(Class) || subject.is_a?(Module)
      p 'class / mod'
      name = subject.name
    elsif subject.is_a? String
      p 'string'
      name = subject
    elsif subject.is_a? Symbol
      p 'symbol'
      name = subject.to_s
    else
      p 'object'
      p "!!! #{subject.class.name}"
      name = subject.class.name
    end
    name
  end
end
