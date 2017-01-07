
# Here the magic happens!
# Get All Controller Subclasses
ObjectSpace.each_object(Class).select do |klass|
	# get all classes inhered from Controller

	klass < Controller
end.each do |klass|
	# Now its time to define getters to that instance variables

	klass.class_variables.each do |var|
		# var = @@name_of_var
		var2 = var.to_s.match(/[\wd]+/).to_s
		# var2 = name_of_var

		# Define accessors
		klass.define_singleton_method(var2) do
			# Get lambda
			klass.class_variable_get(var)
		end

	end

end
