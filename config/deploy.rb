# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'MagicboxBackend'
set :repo_url, 'git@bitbucket.org:magicbox/magicboxbackend.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/facebook.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  task :setup_config do
    on roles(:app) do
      upload!("config/database.yml", "#{shared_path}/config/database.yml")
      upload!("config/facebook.yml", "#{shared_path}/config/facebook.yml")
      upload!("config/secrets.yml", "#{shared_path}/config/secrets.yml")
      puts "Now edit the config files in #{shared_path}."
    end
  end
  before "deploy:starting", "deploy:setup_config"


  desc 'Reload nginx'
  task :reload_nginx do
    on roles(:app) do
      sudo "ln -nfs #{release_path}/config/nginx.conf.#{fetch(:rails_env)} /etc/nginx/sites-enabled/#{fetch(:application)}"
      sudo "service nginx reload"
    end
  end
  after "deploy:updating", "deploy:reload_nginx"


  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup' # keep only the last 5 releases
end