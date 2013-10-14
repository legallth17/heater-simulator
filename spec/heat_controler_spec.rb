require "heater_simulator/heat_controler"

describe HeatControler do
	describe "default values" do
		its(:target_temperature) { should == 19 }
		its(:threshold) { should == 0.5 }
	end
	describe "check_temperature" do
		let(:probe)  { double "probe"  }
		let(:heater) { double "heater" }
		before :each do
			subject.probe  = probe
			subject.heater = heater
		end
		it "starts heater when heater is stopped and temperature is lower than min threshold" do
			probe.stub(:temperature).and_return(18)
			heater.stub(:started?).and_return(false)
			heater.should_receive(:start)
			subject.check_temperature
		end
		it "stops heater when heater is started and temperature is greater than max threshold" do
			probe.stub(:temperature).and_return(20)
			heater.stub(:started?).and_return(true)
			heater.should_receive(:stop)
			subject.check_temperature
		end
		it "does not start heater when heater is stopped and temperature is greater than min threshold" do
			probe.stub(:temperature).and_return(19)
			heater.stub(:started?).and_return(false)
			heater.should_receive(:start).never
			subject.check_temperature
		end
		it "does not stop heater when heater is started and temperature is lower than min threshold" do
			probe.stub(:temperature).and_return(18)
			heater.stub(:started?).and_return(true)
			heater.should_receive(:stop).never
			subject.check_temperature
		end
	end

end