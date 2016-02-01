rails_root = File.expand_path('../../', __FILE__)
rails_env = ENV['RAILS_ENV'] || "development"

worker_processes 2
working_directory rails_root

listen File.expand_path('tmp/sockets/unicorn.sock', shared_path)
pid File.expand_path('tmp/pids/unicorn.pid', shared_path)

stderr_path "#{rails_root}/log/#{rails_env}_unicorn_error.log"
stdout_path "#{rails_root}/log/#{rails_env}_unicorn.log"

