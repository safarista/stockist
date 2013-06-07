require "bundler/capistrano"
require "capistrano-rbenv"

server "192.168.2.19", :web, :app, :db, primary: true

set :application, "stockist"
set :user, "nelsonk"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rbenv_ruby_version, "1.9.3-p392"
set :rbenv_path, "$HOME/.rbenv"

set :scm, :git
set :repository,  "https://github.com/safarista/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup" #keep only the last 5 releases

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do; end
  task :stop do; end
  task :restart, roles: :app, except: { no_release: true } do
    run "touch #{ deploy_to}/current/tmp/restart.txt"
  end

  desc "Setting config files"
  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/apache.conf /etc/apache2/sites-available/#{application}"
    run "#{sudo} mkdir -p #{shared_path}/config"
    puts File.read("config/database.sample.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit config files in #{shared_path}"
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  before "deploy", "deploy:check_revision"
end