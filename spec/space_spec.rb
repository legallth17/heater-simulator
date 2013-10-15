require "heater_simulator/space"

describe Space do
	describe "default values" do 
		its(:temperature) { should == 20 }
	end
	it "can increase its temperature" do
		expect { subject.increase_temperature(0.1) }.to change { subject.temperature }.by(0.1)
	end
	it "can decrease its temperature" do
		expect { subject.decrease_temperature(0.1) }.to change { subject.temperature }.by(-0.1)
	end
end