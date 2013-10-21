class Heater
	attr_accessor :power, :state, :water_temperature

	def initialize
		@power = 0
		@state = :stopped
		@water_temperature = :nil
	end

	def start
		@state = :started
	end

	def stop
		@state = :stopped
	end

	def actual_power
		return 0 unless started?
		return 0 unless @water_temperature
		(@power*@water_temperature)/60
	end

	def started?
		@state == :started
	end
end