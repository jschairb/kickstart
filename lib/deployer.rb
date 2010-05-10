require 'fileutils'

class Deployer
  attr_accessor :environment, :project

  CAP_BIN     = "/usr/local/ruby/bin/cap"
  GIT_BIN     = "/usr/local/bin/git"
  APP_ROOT    = File.join(File.expand_path(File.dirname(__FILE__)), "..")
  DEPLOY_ROOT = File.join(APP_ROOT, "deploy")

  def initialize(project, environment)
    @project = project
    @environment = environment
  end

  def cd_command
    path = File.join(DEPLOY_ROOT, @project.path)
    "cd #{path}"
  end

  def deploy_command
    format_command([CAP_BIN, environment, "deploy"])
  end

  def fetch_command
    git_command = "fetch"
    remote      = "origin"
    format_command([GIT_BIN, git_command, remote ])
  end

  def reset_command
    git_command = "reset"
    options     = "--hard origin/master"
    format_command([GIT_BIN, git_command, options])
  end

  def run
    commands = [ cd_command, fetch_command, reset_command, deploy_command ]
    status = `#{commands.join(" && ")}`
    return status
  end

  protected

  def format_command(commands)
    commands.join(" ")
  end
end
