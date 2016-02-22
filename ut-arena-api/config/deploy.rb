set :application, 'ut-arena'

set :deploy_to, "/home/vagrant/rails/ut-arena"
set :repo_url, "http://github.com/blstream/ut-arena.git"

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :format, :pretty
set :log_level, :debug
set :pty, true

set :user, 'vagrant'

set :keep_releases, 5
