$: << File.join(File.dirname(__FILE__), 'lib')

require 'rubygems'
require 'sinatra'
require 'yaml'

require 'project'
require 'deployer'

configure do
  APP_ROOT = File.expand_path(File.dirname(__FILE__))
  PROJECTS = YAML.load_file(File.join(APP_ROOT, "config", "projects.yml"))
  CREDENTIALS = YAML.load_file(File.join(APP_ROOT, "config", "credentials.yml"))
end

use Rack::Auth::Basic do |username, password|
  [username, password] == [CREDENTIALS['username'], CREDENTIALS['password']]
end

get '/' do
  @projects = PROJECTS.collect { |project| Project.new(project[1])}
  erb :index
end

post '/deploy' do
  @project = Project.new(PROJECTS[params[:project]])
  environment = params[:environment]

  @status = Deployer.new(@project, environment).run
  redirect("/")
end

