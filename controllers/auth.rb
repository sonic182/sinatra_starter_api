class AuthController < Controller

  @@login = lambda do
    erb :login
  end

  @@signin = lambda do
    @user = User.login(params)
    if @user
      session[:user_id] = @user.id
      redirect(url('/'))
    else
      erb :login
    end
  end

  @@signout = lambda do
    erb :signout
  end

  @@signout_post = lambda do
    session[:user_id] = nil
    redirect(url('/'))
  end

  @@signup = lambda do
    erb :signup
  end

  @@signup_post = lambda do
    # puts "params"
    # puts params
    @user = User.new(params)
    if @user.valid? && @user.save
      session[:user_id] = @user.id
      redirect(url('/'))
    else
      erb :signup
    end
  end

end
