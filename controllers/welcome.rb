class WelcomeController < Controller

  @@index = lambda do
    if is_authenticated?
      @user = current_user
      if @user.update(count: @user.count + 1)
        @updated = true
      else
        @updated = false
      end
    end

    erb :index
  end

end
