require 'rubygems'
require 'sinatra'

root_dir = File.dirname(__FILE__)

require File.join(root_dir, "kickstart.rb")

set :root,        root_dir
set :app_file,    File.join(root_dir, 'kickstart.rb')
set :run, false
set :environment, :development
set :views, File.join(root_dir, "views")
set :public, File.join(root_dir, "public")

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application
