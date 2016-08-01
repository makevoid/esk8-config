# initialize bundler
require 'bundler'
Bundler.require

# you can comment this line to disable live-reload
use Inesita::LiveReload

# TODO FIXME
#
# xml_motor_path = "#{Gem.path[0]}/gems/xml-motor-0.1.6/lib"
# s.append_path xml_motor_path
XML_MOTOR = true

# run inesita server
run Inesita::Server.new
