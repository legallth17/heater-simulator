require "heater_simulator/heater"

describe Heater do
	let(:heater) { Heater.new }
	let(:room) { double("room") }
	subject { heater }
	describe "init values" do
		its(:state) { should == :stopped }				
		its(:power) { should == 0 }	
		its(:water_temperature) { should == 60 }	
	end
	describe "actual_power" do
		before(:each) do
			room.stub(:temperature).and_return(20)
			heater.room	= room
			heater.power = 5
			heater.water_temperature = 60
			heater.state = :started
		end
		it "returns a power when heater is started" do
			expect(heater.actual_power > 0).to be_true
		end
		it "returns 0 when heater is stopped" do
			heater.state = :stopped
			expect(heater.actual_power).to eq(0)
		end
		it "depends on water temperature" do
			heater.water_temperature = 60
			power_at_60 = heater.actual_power
			heater.water_temperature = 50
			power_at_50 = heater.actual_power
			expect(power_at_60 > power_at_50).to be_true
		end
		it "depends on room temperature" do
			heater.room = double("room")
			heater.room.stub(:temperature).and_return(18,20)
			power_at_18 = heater.actual_power
			power_at_20 = heater.actual_power
			puts "#{power_at_18} #{power_at_20}"
			expect(power_at_18 > power_at_20).to be_true
		end
		it "raises an error when room is not set" do
			heater.room = nil
			expect{ heater.actual_power }.to raise_error( "room should be set")
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