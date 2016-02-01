# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'Goinder'
set :repo_url, 'git@github.com:katsuya0515/Goinder.git'
set :deploy_to, '/var/www/myapp'

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets}
 
# nokogiri はシステムライブラリを使うため bundle install にオプションを指定する
#set :bundle_env_variables, { nokogiri_use_system_libraries: 1 }
#set :bundle_env_variables, { 'NOKOGIRI_USE_SYSTEM_LIBRARIES' => 1 }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
end
after 'deploy:publishing', 'deploy:restart'

