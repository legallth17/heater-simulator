class Room
	attr_accessor :temperature, :outside_temperature, :volume, :surface, :thermal_resistance
	attr_accessor :heater

	def adjust_temperature
		@temperature -= compute_heat_loss
		@temperature += compute_heat_gain
	end

	def compute_heat_loss
		(@surface * (@temperature-@outside_temperature))/(@volume*@thermal_resistance*1205)
	end

	def compute_heat_gain
		@heater.actual_power / (1.2*@volume*1004)
	end
end