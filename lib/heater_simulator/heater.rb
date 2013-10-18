class Heater
	attr_accessor :power, :state

	def initialize
		@power = 0
		@state = :stopped
	end

	def start
		@state = :started
	end

	def stop
		@state = :stopped
	end

	def actual_power
		return 0 unless started?
		@power
	end

	def started?
		@state == :started
	end
end