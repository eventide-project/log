require 'rainbow'; Rainbow.enabled = true

require 'initializer'; Initializer.activate
require 'dependency'; Dependency.activate
require 'telemetry'
require 'clock'

class Log
end

require 'log/subject_name'
require 'log/registry'
require 'log/dependency'
require 'log/level'
require 'log/levels'
require 'log/filter'
require 'log/telemetry'
require 'log/substitute'
require 'log/log'

