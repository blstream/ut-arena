# The application name is set here
set :application, 'ut-arena'
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

# liked files
set :linked_files, %w{config/database.yml config/secrets.yml}


# url to the repo
set :repo_url, "http://github.com/blstream/ut-arena.git"

# Prompt user for the branch that would be used
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :format, :pretty
set :log_level, :debug
set :pty, true

# How many releases would be kept
set :keep_releases, 5


namespace :deploy do

  desc 'Setup API'
  task :setup do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute "cd #{release_path}/ut-arena-www; npm install; bower install"
        execute :rake, "-f #{release_path}/ut-arena-api/Rakefile db:setup"
      end
    end
  end

  desc 'Start API and frontend'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute "cd #{release_path}/ut-arena-api; rails s -b 192.168.33.10 -d"
        execute "npm --prefix #{release_path}/ut-arena-www/ start"
      end
    end
  end

  desc 'Stop API'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute "kill -9 $(cat #{release_path}/ut-arena-api/tmp/pids/server.pid)"
        execute "rm #{release_path}/ut-arena-api/tmp/pids/server.pid"
      end
    end
  end

  desc 'Restart API'
  task :restart do
    invoke "deploy:stop"
    invoke "deploy:start"
  end

  after :finishing, 'deploy:cleanup'

end
