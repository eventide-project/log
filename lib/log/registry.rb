class Log
  module Registry
    def get(subject)
      register(subject)
    end

    def register(subject)
      subject_name = subject_name(subject)

      instance = registry[subject_name]

      if instance.nil?
        instance = build(subject)
        registry[subject_name] = instance
      end

      instance
    end

    def registry
      @registry ||= {}
    end
  end
end
