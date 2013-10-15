class Probe
	attr_accessor :monitored_space

	def temperature
		return nil if !@monitored_space
		@monitored_space.temperature
	end
end