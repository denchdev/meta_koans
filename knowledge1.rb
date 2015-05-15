class Object
	def attribute *args
		return if args.size == 0
		vars = {}
		args.each do |arg|
			arg.is_a?(Hash) ? arg.each_pair {|k, v| vars[k] = v} : vars[arg] = nil
		end
		code = ""
		vars.each_pair do |k, v|
			code << "def #{k}; #{v}; end\n"
			code << "def #{k}=(value); vars[k] = value; end\n"
			code << "def #{k}?; @#{k}.nil? ? false : true; end\n"
		end
		
		class_eval code
	end
end

