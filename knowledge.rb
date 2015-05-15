def attribute args, &block 
	args.is_a?(Hash) ? 
		args.each_pair {|key, value| add_variable(key, value)} : 
		add_variable(args, block_given?? block : nil)
end

def add_variable(symbol, default)
	getter = symbol
	setter = :"#{symbol}="
	variable = :"@#{symbol}"
	is_define = :"#{symbol}?"

	define_method getter do
		if instance_variable_defined? variable
			instance_variable_get variable
		else
			default.is_a?(Proc) ? instance_eval(&default) : default
		end
	end

	define_method setter do |value|
		instance_variable_set variable, value
	end

	define_method is_define do
		instance_variable_defined? variable
	end

	define_method is_define do
		!send(symbol.to_sym).nil?
	end

end



