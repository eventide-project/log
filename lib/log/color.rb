class Telemetry
  module Logger
    module Color
      extend self

      def apply(level, message)
        if respond_to? level
          send level, message
        else
          message
        end
      end

      def metadata(text)
        Rainbow(text).yellow
      end

      def todo(message)
        Rainbow(message).bright.white.bg(:white)
      end

      def fubar(message)
        Rainbow(message).red.bg(:yellow)
      end

      def obsolete(message)
        Rainbow(message).bright.white
      end

      def opt_data(message)
        data(message)
      end

      def data(message)
        Rainbow(message).cyan
      end

      def opt_trace(message)
        trace(message)
      end

      def trace(message)
        Rainbow(message).white
      end

      def info(message)
        Rainbow(message).green
      end

      def pass(message)
        Rainbow(message).black.bg(:green)
      end

      def fail(message)
        Rainbow(message).black.bg(:red)
      end

      def focus(message)
        Rainbow(message).bright.white.bg(:blue)
      end

      def warn(message)
        Rainbow(message).yellow.bg(:black)
      end

      def error(message)
        Rainbow(message).red.bg(:black)
      end

      def fatal(message)
        Rainbow(message).white.bg(:black)
      end
    end
  end
end
