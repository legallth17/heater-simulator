class Heater
	attr_accessor :power, :state, :water_temperature, :room

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
		raise "room should be set" if !@room
		nwt = 60
		nrt = 20
		return 0 unless started?
		return 0 unless @water_temperature
		1.0*@power*(@water_temperature-@room.temperature)/(nwt-nrt)
	end

	def started?
		@state == :started
	end
end