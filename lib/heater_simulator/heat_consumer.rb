class HeatConsumer
	attr_accessor :inside, :outside, :heat_law, :thermal_resistance

	def consume_heat
		delta = @heat_law.heat_loss(@outside.temperature, @inside.temperature, @thermal_resistance)
		@inside.decrease_temperature(delta)
	end
end