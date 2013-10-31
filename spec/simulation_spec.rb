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
		it "should call controller and adjust room temperature for each second" do
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
	describe "filter_results" do
		before(:each) do
			simulation.stub(:results).and_return (0..100).to_a
		end
		it "returns 7 points for a step of 10 and duration of 69s" do
			simulation.duration = 69
			expect(simulation.filter_results(10)).to be == [0,10,20,30,40,50,60]
		end
		it "returns 8 points for a step of 10 and duration of 70s" do
			simulation.duration = 70
			expect(simulation.filter_results(10)).to be == [0,10,20,30,40,50,60,70]
		end
		it "returns 11 with a step of 1 and duration of 10s" do
			simulation.duration = 10
			expect(simulation.filter_results(1)).to be == [0,1,2,3,4,5,6,7,8,9,10]
		end
	end
end