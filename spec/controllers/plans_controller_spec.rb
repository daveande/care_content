require 'spec_helper.rb'

describe PlansController do
  describe 'GET index' do
    it "should render index template" do
      get :index
      response.should render_template :index
    end
    it "should assign plans to instance variable" do
      @plan = FactoryGirl.create(:plan)
      get :index
      assigns(:plans).should == [@plan]
    end
    it "should order plans by max downloads" do
      @plan1 = Plan.create(:name => '5/month',
                          :price => 500,
                          :genre => 'Annual Subscription',
                          :downloads_per => 'month',
                          :max_downloads => 5
                          )
      @plan2 = Plan.create(:name => '10/month',
                          :price => 500,
                          :genre => 'Annual Subscription',
                          :downloads_per => 'month',
                          :max_downloads => 10
                          )
      get :index
      assigns(:plans).should == [@plan1, @plan2]
    end
  
  end


end
