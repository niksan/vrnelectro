set :application,          'shop.vrnelectro'
set :repo_url,             'git://github.com/niksan/vrnelectro.git'
set :scm,                  :git
set :rails_env,            'production'
set :rvm_ruby_string,      '2.0.0-p247@rails4'
set :deploy_to,            "/srv/htdocs/#{fetch(:application)}"
set :unicorn_conf,         "#{fetch(:deploy_to)}/current/config/unicorn.rb"
set :unicorn_pid,          "#{fetch(:deploy_to)}/shared/pids/unicorn.pid"
set :bundle_cmd,           "rvm use #{fetch(:rvm_ruby_string)} do bundle install"
set :format,               :pretty
set :log_level,            :debug
set :pty,                  true
set :linked_files,         %w{config/database.yml}
set :linked_dirs,          %w{bin log vendor/bundle public/system}
set :keep_releases,        5

set :unicorn_start_cmd,    "cd #{fetch(:deploy_to)}/current; #{fetch(:bundle_cmd)}; bundle exec unicorn_rails -Dc #{fetch(:unicorn_conf)} -E production"

namespace :deploy do

  desc 'Start application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute fetch(:unicorn_start_cmd)
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute "[ -f #{fetch(:unicorn_pid)} ] && kill -QUIT `cat #{fetch(:unicorn_pid)}`"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute ""
      execute "cd #{fetch(:deploy_to)}/current; #{fetch(:bundle_cmd)}; [ -f #{fetch(:unicorn_pid)} ] && kill -USR2 `cat #{fetch(:unicorn_pid)}` || #{fetch(:unicorn_start_cmd)}"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end

  after :finishing, 'deploy:cleanup'

end
