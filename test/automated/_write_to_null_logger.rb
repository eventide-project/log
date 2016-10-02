require_relative '../test_init'

module WriteToNullLogger
  class Example
    dependency :logger, Telemetry::Logger

    def self.build
      instance = new
      instance
    end

    def fubar
      logger.fubar "This fubar message should not be written"
    end

    def obsolete
      logger.obsolete "This obsolete message should not be written"
    end

    def data
      logger.data "This data message should not be written"
    end

    def trace
      logger.trace "This trace message should not be written"
    end

    def debug
      logger.debug "This debug message should not be written"
    end

    def opt_data
      logger.opt_data "This opt_data message should not be written"
    end

    def opt_trace
      logger.opt_trace "This opt_trace message should not be written"
    end

    def opt_debug
      logger.opt_debug "This opt_debug message should not be written"
    end

    def info
      logger.info "This info message should not be written"
    end

    def pass
      logger.pass "This pass message should not be written"
    end

    def fail
      logger.fail "This fail message should not be written"
    end

    def focus
      logger.focus "This focus message should not be written"
    end

    def warn
      logger.warn "This warn message should not be written"
    end

    def error
      logger.error "This error message should not be written"
    end

    def fatal
      logger.fatal "This fatal message should not be written"
    end
  end
end

e = WriteToNullLogger::Example.build
e.fubar
e.obsolete
e.data
e.trace
e.debug
e.opt_data
e.opt_trace
e.opt_debug
e.info
e.pass
e.fail
e.warn
e.error
e.fatal
