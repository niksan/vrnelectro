set :application,          'shop.vrnelectro'
set :repo_url,             'git://github.com/niksan/vrnelectro.git'
set :scm,                  :git
set :deploy_to,            "/srv/htdocs/#{fetch(:application)}"
set :unicorn_conf,         "#{fetch(:deploy_to)}/current/config/unicorn.rb"
set :unicorn_pid,          "#{fetch(:deploy_to)}/shared/pids/unicorn.pid"
set :format,               :pretty
set :log_level,            :debug
set :pty,                  true
set :linked_files,         %w{config/database.yml}
set :linked_dirs,          %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :keep_releases,        5
set :unicorn_start_cmd,    "(cd #{fetch(:deploy_to)}/current; rvm use #{fetch(:rvm_ruby_string)} do bundle exec unicorn_rails -Dc #{fetch(:unicorn_conf)} -E production)"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
