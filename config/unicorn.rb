rails_root = File.expand_path('../../', __FILE__)
rails_env = ENV['RAILS_ENV'] || "development"

worker_processes 2
working_directory rails_root

listen "/tmp/unicorn.sock"
#listen 8080
pid "/tmp/unicorn.pid"

stderr_path "#{rails_root}/log/#{rails_env}_unicorn_error.log"
stdout_path "#{rails_root}/log/#{rails_env}_unicorn.log"

 before_exec do |server|
      ENV['BUNDLE_GEMFILE'] = "#{root}/Gemfile"
    end

