class WelcomeController < Controller

  @@index = lambda do
    Counter.db.transaction do
      @count = Counter.where(id: 1).first || Counter.new(counter: 0)
      @count.counter += 1
      @count.save
    end

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
