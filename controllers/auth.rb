module Sinatra
  module MyApp
    module Controllers
      module Auth

        def self.registered(app)

					login = lambda do
            erb :login
          end

          signup = lambda do
            session[:user_id] = params['name']
            redirect(url('/'))
          end

          signout = lambda do
            session[:user_id] = nil
            redirect(url('/'))
          end

          app.get  '/login', &login
          app.post  '/signup', &signup
          # UNSAFE, must be post method
          app.get  '/signout', &signout
        end
      end
    end
  end
end
