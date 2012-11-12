require 'spec_helper'

describe Purchase do
  before(:each) do
    @plan = FactoryGirl.create(:plan)
    @user = FactoryGirl.create(:user)
    @attr = {:plan_id => @plan.id,
             :user_id => @user.id,
             :period_end => Time.now() + 1.years,
             :agreed_to_terms => true
            }
  end
  it "should create a new instance with valid attributes" do
    Purchase.create!(@attr)
  end
  it "should require a user" do
    no_user = Purchase.new(@attr.merge(:user_id => nil))
    no_user.should_not be_valid
  end
  it "should require a plan" do
    no_plan = Purchase.new(@attr.merge(:plan_id => nil))
    no_plan.should_not be_valid
  end
  it "should default to expired false" do
    purchase = Purchase.create!(@attr)
    purchase.expired.should == false
  end
  it "should respond to user" do
    purchase = Purchase.create!(@attr)
    purchase.user.should == @user
  end
  it "should respond to plan" do
    purchase = Purchase.create!(@attr)
    purchase.plan.should == @plan
  end
  it "should not allow a downgrade subscription" do
    @plan1 = Plan.create(:name => '10/month',
                        :price => 500,
                        :genre => 'Annual Subscription',
                        :downloads_per => 'month',
                        :max_downloads => 10
                        )
    @plan2 = Plan.create(:name => '5/month',
                        :price => 500,
                        :genre => 'Annual Subscription',
                        :downloads_per => 'month',
                        :max_downloads => 5
                        )
    first_purchase = Purchase.create!(@attr.merge(:plan_id => @plan1.id))
    downgrade_purchase = Purchase.new(@attr.merge(:plan_id => @plan2.id))
    downgrade_purchase.should_not be_valid
    downgrade_purchase.errors.messages.should == {:purchase => ["cannot be a downgrade. Please contact us to downgrade your subscription. kadesha@carecontent.com, 312-532-1362"]}
  end
  it "should expire monthly plans after create" do
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
    first_purchase = Purchase.create!(@attr.merge(:plan_id => @plan1.id))
    second_purchase = Purchase.create!(@attr.merge(:plan_id => @plan2.id))
    first_purchase.reload
    second_purchase.reload
    first_purchase.expired.should == true
    second_purchase.expired.should == false
  end

  describe 'current_expire method' do
    context 'with an a la carte plan' do
      it "should return min: created_at and max: period_end" do
        @plan1 = Plan.create(:name => '10/year',
                            :price => 500,
                            :genre => 'A la Carte',
                            :downloads_per => 'year',
                            :max_downloads => 10
                            )
        purchase = Purchase.create(@attr.merge(:plan_id => @plan1.id))
        min = purchase.created_at
        max = purchase.period_end
        returned_min, returned_max = purchase.current_expire
        Time.at(min).should == Time.at(returned_min)
        Time.at(max).should == Time.at(returned_max)
      end
    end
    context "with an annual subscription plan" do
      context "during it's first month" do
        it "should return the min date of the month and max date of the current month" do
          @plan1 = Plan.create(:name => '10/month',
                              :price => 500,
                              :genre => 'Annual Subscription',
                              :downloads_per => 'month',
                              :max_downloads => 10
                              )
          purchase = Purchase.create(@attr.merge(:plan_id => @plan1.id))
          min = purchase.created_at
          max = purchase.created_at + 1.months
          returned_min, returned_max = purchase.current_expire
          Time.at(min).should == Time.at(returned_min)
          Time.at(max).should == Time.at(returned_max)
        end
      end
      context "during it's fourth month" do
        it "should return the min date of the month and max date of the current month" do
          @plan1 = Plan.create(:name => '10/month',
                              :price => 500,
                              :genre => 'Annual Subscription',
                              :downloads_per => 'month',
                              :max_downloads => 10
                              )
          purchase = Purchase.create(@attr.merge(:plan_id => @plan1.id))
          purchase.reload
          time_elapsed = Time.now() + 4.months + 2.days
          Time.stub(:now => time_elapsed)
          min = purchase.created_at + 4.months
          max = purchase.created_at + 5.months
          returned_min, returned_max = purchase.current_expire
          Time.at(returned_max).should == Time.at(purchase.created_at + 5.months)
          Time.at(returned_min).should == Time.at(purchase.created_at + 4.months)
        end
      end

    end
  end
end
