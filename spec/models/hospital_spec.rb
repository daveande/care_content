require 'spec_helper'

describe Hospital do
  before(:each) do 
    @service_area = FactoryGirl.create(:service_area)
    @attr = {:name => 'Detroit Medical',
             :service_area_id => @service_area.id
            }
  end

  it "should create an instance with valid attributes" do
    Hospital.create!(@attr)
  end
  it "should require a name" do
    no_name = Hospital.new(@attr.merge(:name => ''))
    no_name.should_not be_valid
  end
  it "should require a service area " do
    no_service_area = Hospital.new(@attr.merge(:service_area_id => nil))
    no_service_area.should_not be_valid
  end
end
