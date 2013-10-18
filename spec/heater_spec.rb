require "heater_simulator/heater"

describe Heater do
	let(:heater) { Heater.new }
	subject { heater }
	describe "init values" do
		its(:state) { should == :stopped }				
		its(:power) { should == 0 }				
	end
	describe "actual_power" do
		it "returns 0 when heater is stopped" do
			heater.power = 5
			heater.state = :stopped
			expect(heater.actual_power).to eq(0)
		end
		it "returns power when heater is started" do
			heater.power = 5
			heater.state = :started
			expect(heater.actual_power).to eq(5)
		end
	end
	describe "stop" do
		it "sets state to :stopped" do
			# given
			heater.state = :started
			# when
			heater.stop
			# then
			expect(heater.state).to eq(:stopped)
		end
	end
	describe "start" do
		it "sets state to :started" do
			# given
			heater.state = :stopped
			# when
			heater.start
			# then
			expect(heater.state).to eq(:started)
		end
	end
	describe "started?" do
		it "returns true when state is :started" do
			# given
			heater.state = :started
			# then
			expect(heater.started?).to be_true
		end
		it "returns false when state is :stopped" do
			# given
			heater.state = :stopped
			# then
			expect(heater.started?).to be_false
		end
	end
end