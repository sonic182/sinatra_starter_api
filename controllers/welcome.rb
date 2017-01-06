module Sinatra
  module MyApp
    module Controllers
      module Welcome

        def self.registered(app)

					index = lambda do
            require_logged_in
						@items = DB[:items].all
            erb :index
          end

          app.get  '/', &index
        end

      end
    end
  end
end
