class WelcomeController < Controller

  @@index = lambda do
    'Hello World'
  end

  @@json = lambda do
    json as: :df
  end

end
