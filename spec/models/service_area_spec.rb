require 'spec_helper'

describe ServiceArea do
  it "should create an instance with valid attributes" do
    ServiceArea.create!(:name => 'Hello')
  end
  it "should require a name" do
    no_name = ServiceArea.create(:name => nil)
    no_name.should_not be_valid
  end
end
