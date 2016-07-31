# initialize bundler
require 'bundler'
Bundler.require

# you can comment this line to disable live-reload
use Inesita::LiveReload

Opal.use_gem 'xml-motor'

# run inesita server
run Inesita::Server.new
