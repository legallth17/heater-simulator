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
			heater.stub(:water_temperature=)
			subject.stub(:heater_water_temperature).and_return(30)
		end
		it "starts heater when heater is stopped and temperature (eg 18.4) is lower than min threshold (eg 18.5)" do
			probe.stub(:temperature).and_return(18.4)
			heater.stub(:started?).and_return(false)
			heater.should_receive(:start)
			subject.check_temperature
		end
		it "stops heater when heater is started and temperature (eg 19.6) is greater than max threshold (eg 19.5)" do
			probe.stub(:temperature).and_return(19.6)
			heater.stub(:started?).and_return(true)
			heater.should_receive(:stop)
			subject.check_temperature
		end
		it "does not start heater when heater is stopped and temperature (eg 19) is greater than min threshold (eg 18.5)" do
			probe.stub(:temperature).and_return(19)
			heater.stub(:started?).and_return(false)
			heater.should_receive(:start).never
			subject.check_temperature
		end
		it "does not stop heater when heater is started and temperature (eg 18.4)  is lower than min threshold (eg 18.5)" do
			probe.stub(:temperature).and_return(18.4)
			heater.stub(:started?).and_return(true)
			heater.should_receive(:stop).never
			subject.check_temperature
		end
		it "updates heater water temperature when heater is started" do
			probe.stub(:temperature).and_return(19)
			heater.stub(:started?).and_return(true)
			heater.should_receive(:water_temperature=).with(30)
			subject.check_temperature
		end
	end
	describe "heater_water_temperature" do
		it "depends outside temperature" do
			subject.stub(:outside_temperature)
			subject.heater.stub(:room).and_return(double())
			subject.heater.room.stub(:outside_temperature).and_return(10,20)
			t1 = subject.heater_water_temperature
			t2 = subject.heater_water_temperature
			expect(t1).to be > t2
		end
	end
end