require_relative './interactive_init'

logger = Log.build($stdout)

logger.fatal("Fatal message")
logger.error("Error message")
logger.warn("Warning message")
logger.info("Info message")
logger.debug("Debug message")
logger.trace("Trace message")
