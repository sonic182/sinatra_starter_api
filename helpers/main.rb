module Sinatra
  module MyApp
    module Helpers

      def require_logged_in
        redirect("/#{current_locale}/login") unless is_authenticated?
      end

      def is_authenticated?
        return !!session[:user_id]
      end

      # Always absolute urls!
      def url str
        "/#{current_locale}" + str
      end

      def t(*args)
        I18n.t(*args)
      end

      def current_locale
        I18n.locale
      end

      def current_user
        @user || @use = User.where(id: session[:user_id]).first
      end

      def logger
        request.logger
      end

    end
  end
end
