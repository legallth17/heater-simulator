class Room
	attr_accessor :temperature, :outside_temperature, :volume, :surface, :thermal_resistance
	attr_accessor :heat_law

	def lost_heat
		@temperature -= compute_heat_loss
	end

	def compute_heat_loss
		(@surface * (@temperature-@outside_temperature))/(@volume*@thermal_resistance*1205)
	end
end