class Heater
	attr_accessor :power, :state, :water_temperature, :room

	def initialize
		@power = 0
		@state = :stopped
		@water_temperature = 60
	end

	def start
		@state = :started
	end

	def stop
		@state = :stopped
	end

	def actual_power
		raise "room should be set" if !@room
		raise "water temperature should be set" if !@water_temperature
		return 0 unless started?
		nwt = 60
		nrt = 20
		1.0*@power*(@water_temperature-@room.temperature)/(nwt-nrt)
	end

	def started?
		@state == :started
	end
end