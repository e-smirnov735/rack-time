require_relative 'app'

ROUTES = {
  '/time' => App.new
}.freeze

run Rack::URLMap.new(ROUTES)
