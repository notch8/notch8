set :application, "notch8"
set :repository,  "git@github.com:notch8/notch8.git"
set :domain, "72.14.182.60"
set :deploy_to, "/var/www/apps/#{application}"

set :scm, :git

role :web, domain
role :app, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start do
  end
  task :stop do
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end