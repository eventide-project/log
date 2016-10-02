require_relative '../test_init'

module WriteLogMessages
  class Example
    attr_accessor :logger

    def self.build
      instance = new
      Telemetry::Logger.configure instance
      instance
    end

    def todo
      logger.todo "This is a todo"
    end

    def fubar
      logger.fubar "This is a fubar"
    end

    def obsolete
      logger.obsolete "This is an obsolete"
    end

    def data
      logger.data "This is a data"
    end

    def multiline_data
      logger.data "This\n\r\nis\na\r\nmultiline\n\ndata\n\nyeah\n\rok"
    end

    def trace
      logger.trace "This is a trace"
    end

    def debug
      logger.debug "This is a debug"
    end

    def opt_data
      logger.opt_data "This is an optional data"
    end

    def opt_trace
      logger.opt_trace "This is an optional trace"
    end

    def opt_debug
      logger.opt_debug "This is an optional debug"
    end

    def info
      logger.info "This is an info"
    end

    def pass
      logger.pass "This is a pass"
    end

    def fail
      logger.fail "This is a fail"
    end

    def focus
      logger.focus "This is a focus"
    end

    def warn
      logger.warn "This is a warn"
    end

    def error
      logger.error "This is an error"
    end

    def fatal
      logger.fatal "This is a fatal"
    end
  end
end

e = WriteLogMessages::Example.build
e.todo
e.fubar
e.obsolete
e.opt_data
e.opt_trace
e.opt_debug
e.data
e.multiline_data
e.trace
e.debug
e.info
e.pass
e.fail
e.focus
e.warn
e.error
e.fatal
