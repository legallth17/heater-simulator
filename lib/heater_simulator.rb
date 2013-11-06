#require "heater_simulator/version"
require_relative "heater_simulator/simulation"

module HeaterSimulator
end

	def simulation1
		simulation = Simulation.new
		simulation.duration = 600
		simulation.run
		simulation.results_by_step(60).each do |r|
			puts "#{r.time}: #{r.temperature}"
		end
	end

simulation1

