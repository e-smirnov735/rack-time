require_relative 'middleware/routing'
require_relative 'app'

use Routing
run App.new
