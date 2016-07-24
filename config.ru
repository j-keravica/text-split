require "./environment.rb"

$stdout.sync = true

run Rack::URLMap.new("/" => TextColor)