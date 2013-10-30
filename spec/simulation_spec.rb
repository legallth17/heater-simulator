require "heater_simulator/simulation.rb"

describe Simulation do
	let(:simulation) { Simulation.new }
	subject { simulation }
	describe "default values" do
		its("room.temperature")              { should == 18   }
		its("room.outside_temperature")      { should == 10   }		
		its("room.surface")                  { should > 0     }		
		its("room.volume")                   { should > 0     }	
		its("room.thermal_resistance")       { should == 0.5  }
		its("heater.power")                  { should == 5000 }
		its("controler.target_temperature") { should == 20 }	
	end
	describe "run" do
		it "runs simulation during specified duration" do
			simulation.duration = 60
			simulation.controler.should_receive(:check_temperature).exactly(60).times
			simulation.room.should_receive(:adjust_temperature).exactly(60).times
			simulation.run
		end
		it "should change room temperature" do
			simulation.duration = 10
			simulation.run
			expect(simulation.room.temperature).to be > 18
		end
		it "should create results with all measured temperatures" do
			simulation.duration = 10
			simulation.run
			expect(simulation.results.size).to be == 11
			# initial temperature
			expect(simulation.results[0]).to be == 18
			# last temperature
			expect(simulation.results[10]).to be == simulation.room.temperature
		end

	end
end