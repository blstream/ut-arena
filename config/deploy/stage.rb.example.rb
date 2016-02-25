# This example is for the Development stage

# Here the stage name is set, it would later be executed with command like:
# cap production deploy
set :stage, :development

set :rails_env, :development

# User that would be used is set to the development
set :user, "development"

# The server address is defined here
server_address = "192.168.33.10"

# Here are defined roles for the Development server
role :app, "#{fetch :user}@#{server_address}"
role :web, "#{fetch :user}@#{server_address}"
role :db,  "#{fetch :user}@#{server_address}"

# Path where would the application be deployed
set :deploy_to, "/home/development/apps/#{fetch :application}"

# Server settings
server server_address, user: (fetch :user), roles: %w{web app}


# Stage specified deploy tasks should be defined here, like the example below
#
# namespace :deploy do
#
# # The description of the task
#   desc 'Setup API'
# # Task name
#   task :setup do
# # On what roles would the task be executed
#     on roles(:app), in: :sequence, wait: 5 do
#       within release_path do
#         # here are commands to be executed or other operations that you need to do
#         # for example rake db:setup for API
#         # execute :rake, "-f #{release_path}/ut-arena-api/Rakefile db:setup"
#       end
#     end
#   end
#
# end
