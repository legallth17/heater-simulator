class HeatControler 
	attr_accessor :target_temperature, :threshold
	attr_accessor :probe, :heater

	def initialize
		@target_temperature = 19
		@threshold = 0.5
	end
	def check_temperature
		heater.stop  if  heater.started? && @probe.temperature >= (@target_temperature + @threshold)
		heater.start if !heater.started? && @probe.temperature <  (@target_temperature - @threshold)
		heater.water_temperature = heater_water_temperature
	end
	def heater_water_temperature
		(60 - heater.room.outside_temperature)
	end
end