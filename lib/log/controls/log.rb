module Log::Controls
  module Log
    def self.example
      ::Log::Substitute.build
    end

    module Operational
      def self.example
        ::Log.build(subject)
      end

      def self.subject
        'some subject'
      end
    end
  end
end
