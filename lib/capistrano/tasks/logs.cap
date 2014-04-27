set :line_number, 50

namespace :logs do
  desc "tail rails logs" 
  task :tail_rails do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:rails_env)}.log -n #{fetch(:line_number)}"
    end
  end

  desc "tail sidekiq logs" 
  task :tail_sidekiq do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/sidekiq.log -n #{fetch(:line_number)}"
    end
  end

  desc "tail puma access logs" 
  task :tail_puma_access do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/puma_access.log -n #{fetch(:line_number)}"
    end
  end

  desc "tail puma error logs" 
  task :tail_puma_error do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/puma_error.log -n #{fetch(:line_number)}"
    end
  end

  desc "tail nginx access logs" 
  task :tail_nginx_access do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/nginx.access.log -n #{fetch(:line_number)}"
    end
  end

  desc "tail nginx error logs" 
  task :tail_nginx_error do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/nginx.error.log -n #{fetch(:line_number)}"
    end
  end

  desc "tail newrelic logs" 
  task :tail_newrelic do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/newrelic_agent.log -n #{fetch(:line_number)}"
    end
  end
end