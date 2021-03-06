set :application,          'shop.vrnelectro'
set :repo_url,             'git://github.com/niksan/vrnelectro.git'
set :scm,                  :git
set :rails_env,            'production'
set :rvm_ruby_string,      '2.0.0-p353@rails4'
set :deploy_to,            "/srv/htdocs/#{fetch(:application)}"
set :unicorn_conf,         "#{fetch(:deploy_to)}/current/config/unicorn.rb"
set :unicorn_pid,          "#{fetch(:deploy_to)}/shared/pids/unicorn.pid"
set :bundle_cmd,           "cd #{fetch(:deploy_to)}/current; rvm use #{fetch(:rvm_ruby_string)} do bundle exec install"
set :migrate_cmd,          "cd #{fetch(:deploy_to)}/current; RAILS_ENV=#{fetch(:rails_env)} rvm use #{fetch(:rvm_ruby_string)} do bundle exec install"
set :format,               :pretty
set :log_level,            :info
set :pty,                  true
set :linked_files,         %w{config/database.yml}
set :linked_dirs,          %w{bin log vendor/bundle public/system public/uploads}
set :keep_releases,        10
set :unicorn_start_cmd,    "(cd #{fetch(:deploy_to)}/current; rvm use #{fetch(:rvm_ruby_string)} do bundle exec unicorn_rails -Dc #{fetch(:unicorn_conf)} -E #{fetch(:rails_env)})"
set :unicorn_stop_cmd,     "if [ -f #{fetch(:unicorn_pid)} ] && [ -e /proc/$(cat #{fetch(:unicorn_pid)}) ]; then kill -QUIT `cat #{fetch(:unicorn_pid)}`; fi"

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
      execute fetch(:unicorn_stop_cmd)
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute fetch(:unicorn_bundle_cmd)
      execute fetch(:unicorn_migrate_cmd)
      execute fetch(:unicorn_stop_cmd)
      execute fetch(:unicorn_start_cmd)
    end
  end

  after :finishing, 'deploy:cleanup'

end
=begin
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
set :linked_dirs,          %w{bin log vendor/bundle public/system public/uploads}
set :keep_releases,        5

set :unicorn_start_cmd,    "(cd #{fetch(:deploy_to)}/current; rvm use #{fetch(:rvm_ruby_string)} do bundle exec unicorn_rails -Dc #{fetch(:unicorn_conf)} -E #{fetch(:rails_env)})"

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
      execute "if [ -f #{fetch(:unicorn_pid)} ] && [ -e /proc/$(cat #{fetch(:unicorn_pid)}) ]; then kill -QUIT `cat #{fetch(:unicorn_pid)}`; fi"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute ""
      execute "cd #{fetch(:deploy_to)}/current; #{fetch(:bundle_cmd)}; [ -f #{fetch(:unicorn_pid)} ] && kill -USR2 `cat #{fetch(:unicorn_pid)}` || #{fetch(:unicorn_start_cmd)}"
    end
  end


  after :finishing, 'deploy:cleanup'

end
=end
