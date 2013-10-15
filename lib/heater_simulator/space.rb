class Space
	attr_accessor :temperature
	def initialize
		@temperature = 20.0
	end
	def increase_temperature(x)
		@temperature += x
	end
	def decrease_temperature(x)
		@temperature -= x
	end
end