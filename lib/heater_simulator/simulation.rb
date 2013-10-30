require_relative "room.rb"
require_relative "heater.rb"
require_relative "probe.rb"
require_relative "heat_controler.rb"
class Simulation
	attr_accessor :room, :heater, :probe, :controler, :duration
	attr_reader :results

	def initialize
		# the room
		@room  = Room.new
		@room.temperature = 18
		@room.outside_temperature = 10
		@room.surface = 3 * (5+5+10)
		@room.volume = 3 * (10*5)
		@room.thermal_resistance = 0.5
		# the probe
		@probe = Probe.new
		@probe.monitored_space = room
		# the heater
		@heater = Heater.new
		@heater.power = 5000 # W
		@heater.water_temperature = 60
		@room.add_heater( heater )
		# the heat controler
		@controler = HeatControler.new
		@controler.probe  = probe
		@controler.heater = heater
		@controler.target_temperature = 20
	end

	def run
		@results = Array.new
		@results << @room.temperature
		for n in 1..duration do
			controler.check_temperature
			room.adjust_temperature
			@results << @room.temperature
		end
	end
end