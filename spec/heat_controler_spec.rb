require "heater_simulator/heat_controler"

describe HeatControler do
	describe "default values" do
		its(:target_temperature) { should == 19 }
		its(:threshold) { should == 0.5 }
		its(:observed_temperature) { should be_nil }
	end
	describe "run?" do
		before :each do
			subject.target_temperature = 19
			subject.threshold = 0.5
		end
		it "returns true when heat is below target+threshold" do
			subject.observed_temperature = 18.3
			subject.run?.should be_true
		end
		it "returns false when heat equals to target+threshold" do
			subject.observed_temperature = 19.5
			subject.run?.should be_false
		end
		it "returns false when heat is greater than target+threshold" do
			subject.observed_temperature = 20
			subject.run?.should be_false
		end
		it "raises an error when no observed temperature is set" do
			expect { subject.run? }.to raise_error("observed temperature not set")
		end
	end

end