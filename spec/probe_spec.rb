require "heater_simulator/probe"

describe Probe do
	let(:probe) { Probe.new }
	let(:space) { double "space" }
	describe "temperature" do
		it "returns monitored space temperature" do
			probe.monitored_space = space
			space.stub(:temperature).and_return(10)
			expect(probe.temperature).to eq(10)
		end
		it "returns nil when no monitored space is defined" do
			expect(probe.temperature).to eq(nil)
		end		
	end
end
