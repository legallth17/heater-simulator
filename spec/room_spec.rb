require "heater_simulator/room"

describe Room do
	let(:room) { Room.new }
	let(:heater) { double "heater" }
	before(:each) do
		room.temperature = 20
		room.outside_temperature = 10
		room.volume = 3*5*10
		room.surface = 3*(5+10+5)
		room.thermal_resistance = 0.5
		room.heater = heater
	end
	describe "adjust_temperature" do
		it "decreases temperature" do
			room.stub(:compute_heat_loss).and_return(0.5)
			room.stub(:compute_heat_gain).and_return(0)
			expect { room.adjust_temperature }.to change { room.temperature }.by(-0.5)
		end
		it "decreases temperature" do
			room.stub(:compute_heat_loss).and_return(0)
			room.stub(:compute_heat_gain).and_return(0.5)
			expect { room.adjust_temperature }.to change { room.temperature }.by(+0.5)
		end
	end
	describe "compute_heat_loss" do
		it "uses correct formula" do
			s    = room.surface
			t_in  = room.temperature
			t_out = room.outside_temperature
			v    = room.volume
			r    = room.thermal_resistance
			k = (s * (t_in - t_out))/(v*r*1205)
			expect(room.compute_heat_loss).to eq( k )
		end
	end
	describe "compute_heat_gain" do
		it "uses correct formula" do
			p = 5000
			heater.stub(:actual_power).and_return(p)
			v = room.volume
			k = p/(1.2*v*1004)
			expect(room.compute_heat_gain).to eq( k )
		end
	end
end