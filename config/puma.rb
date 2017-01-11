# Ruby
workers Integer(ENV['WEB_CONCURRENCY'] || 4) 							if RUBY_PLATFORM != 'java'

min_threads = RUBY_PLATFORM != 'java' ? 1 : 4
max_threads = RUBY_PLATFORM != 'java' ? 5 : 20

# threads ENV['MIN_THREADS'] || 1, ENV['MAX_THREADS'] || 5
threads ENV['MIN_THREADS'] || min_threads, ENV['MAX_THREADS'] || max_threads

# preload_app! # This decrease performance at last with this sinatra app with ruby,
# this maybe it's only good for rails apps only

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

# on_worker_boot do Rails and ruby stuff...
#   # Worker specific setup for Rails 4.1+
#   # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
#   ActiveRecord::Base.establish_connection
# end
