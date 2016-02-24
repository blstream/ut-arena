# require 'bundler/capistrano'

# The application name is set here
set :application, 'ut-arena'
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

set :puma_threads,    [4, 16]
set :puma_workers,    0

# User that would be used is set to the development
set :user, "development"

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

# Path to gemfile
set :bundle_gemfile, "#{release_path}/ut-arena-api/Gemfile"

# url to the repo
set :repo_url, "http://github.com/blstream/ut-arena.git"

# # Prompt user for the branch that would be used
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Defaults:
set :scm,           :git
set :branch,        :"ut-provisioning"
set :format,        :pretty
set :log_level,     :debug
set :keep_releases, 5


namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/ut-provisioning`
        puts "WARNING: HEAD is not the same as origin/ut-provisioning"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  task :bundle_install do
    on roles(:app) do
      within release_path do

      end
    end
  end
  after 'deploy:updating', 'deploy:bundle_install'

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end
