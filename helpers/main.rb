module Sinatra
  module MyApp
    module Helpers

      # def require_logged_in
      #   redirect("/#{current_locale}/login") unless is_authenticated?
      # end

      def is_authenticated?
        # check token
      end

      # translate tags
      def t(*args)
        I18n.t(*args)
      end

      # locale for dates, times, etc.
      def l(*args)
        I18n.l(*args)
      end

      def current_locale
        I18n.locale
      end

      def set_locale locale
        I18n.locale = locale
      end

      def current_user
        # search with token
      end

      def logger
        request.logger
      end

    end
  end
end
