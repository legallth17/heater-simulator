#require "heater_simulator/version"
require_relative "heater_simulator/heater"
require_relative "heater_simulator/probe"
require_relative "heater_simulator/room"
require_relative "heater_simulator/heat_controler"

module HeaterSimulator
end

	def simulation1
		# the room
		room  = Room.new
		room.temperature = 20
		room.outside_temperature = 10
		room.surface = 3 * (5+5+10)
		room.volume = 3 * (10*5)
		room.thermal_resistance = 0.5
		# the probe
		probe = Probe.new
		probe.monitored_space = room
		# the heater
		heater = Heater.new
		heater.power = 5000 # W
		room.heater  = heater
		# the heat controler
		controler = HeatControler.new
		controler.probe  = probe
		controler.heater = heater
		controler.target_temperature = 20
		n = 1
		t0 = room.temperature
		t = t0
		begin
			controler.check_temperature
			room.adjust_temperature
			delta = room.temperature - t
			t = room.temperature
			puts "#{n}: #{t} #{delta}"
			n += 1
		end while (t < t0)
	end

simulation1

