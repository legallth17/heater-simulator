require "heater_simulator/room"

describe Room do
	let(:room) { Room.new }
	let(:heat_law) { double("heat_law")}
	before(:each) do
		room.temperature = 20
		room.outside_temperature = 10
		room.volume = 3*5*10
		room.surface = 3*(5+10+5)
		room.thermal_resistance = 0.5
		room.heat_law = heat_law
	end
	describe "lost_heat" do
		it "decreases temperature" do
			room.stub(:compute_heat_loss).and_return(0.5)
			expect { room.lost_heat }.to change { room.temperature }.by(-0.5)
		end
	end
	describe "compute_heat_loss" do
		it "uses correct formula" do
			S    = room.surface
			Tin  = room.temperature
			Tout = room.outside_temperature
			V    = room.volume
			R    = room.thermal_resistance
			expected_value = (S * (Tin - Tout))/(V*R*1205)
			expect(room.compute_heat_loss).to eq( expected_value )
		end
	end
end