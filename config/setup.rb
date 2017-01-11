
# Here the magic happens!
# Get All Controller Subclasses
ObjectSpace.each_object(Class).select do |klass|
	klass < Controller
end.each do |controller_subclass|
	# Now its time to define getters to that instance variables

	controller_subclass.class_variables.each do |var|
		var2 = var.to_s.match(/[\wd]+/).to_s

		# var = @@name_of_var
		# var2 = name_of_var

		# Define accessors to class variables as class functions
		controller_subclass.define_singleton_method(var2) do
			# Get route Proc
			controller_subclass.class_variable_get(var)
		end

	end

end
