class HeatControler 
	attr_accessor :target_temperature, :observed_temperature, :threshold

	def initialize
		@target_temperature = 19
		@threshold = 0.5
	end
	def run?
		raise "observed temperature not set" unless @observed_temperature
		@observed_temperature < (@target_temperature + @threshold) 
		
	end
end