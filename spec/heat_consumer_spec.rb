require "heater_simulator/heat_consumer"

describe HeatConsumer do 
	let(:inside)  { double("inside")}
	let(:outside) { double("outside")}
	let(:heat_law) { double("thermal_law")}
	before(:each) do 
		subject.inside  = inside
		subject.outside = outside
		subject.heat_law = heat_law
		subject.thermal_resistance = 2
	end
	describe "consume_heat" do
		it "decreases inside temperature" do
			# configure stubs
			heat_law.stub(:heat_loss).with(0,20,2).and_return(0.5)
			inside.stub(:temperature).and_return(20)
			outside.stub(:temperature).and_return(0)
			# expected mock interactions
			inside.should_receive(:decrease_temperature).with(0.5)
			# test
			subject.consume_heat
		end
	end
	
end