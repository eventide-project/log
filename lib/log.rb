require 'rainbow'; Rainbow.enabled = true

require 'initializer'; Initializer.activate
require 'dependency'; Dependency.activate
require 'telemetry'
require 'clock'

class Log
end

require 'log/subject_name'
require 'log/dependency'
require 'log/log'

