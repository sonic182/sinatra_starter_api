class User < Sequel::Model
	include BCrypt

	def password
		@password ||= Password.new(encrypted_password)
	end

	def password=(new_password)
		@password = new_password
		pass = Password.create(new_password)
		self.encrypted_password = pass
	end

	def validate
		validates_unique :username
		validates_min_length 8, :username
		validates_max_length 16, :username

		validates_min_length 8, :password
		# validates_max_length 16, :password
	end

	# def before_save
	# 	self.encrypt_password
	# 	super
	# end

	# def after_save
	# 	super
	# 	# puts 'after'
	# 	# puts self
	# end

	def self.login params
	  @user = User.where(username: params[:username]).first
	  if @user && @user.password == params[:password]
	    @user
		else
			false
	  end
	end

end
