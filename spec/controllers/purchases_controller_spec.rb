require 'spec_helper.rb'

describe PurchasesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @plan = FactoryGirl.create(:plan)
    @attr = {:plan_id => @plan.id,
             :user_id => @user.id,
             :expired => false,
             :agreed_to_terms => true
    }
  end

  it "should require a signed in user" do
    get :new, :user_id => 1
    response.should redirect_to new_user_session_url
  end

  describe "GET new" do
    before(:each) do
      sign_in(@user)
    end
    context "without a selected plan" do
      it "should redirect to plans_url" do
        get :new, :user_id => @user.id
        response.should redirect_to plans_url
      end
    end
    context "with a selected plan" do
      it "should find and assign the plan" do
        get :new, :user_id => @user.id, :plan_id => @plan.id
        assigns(:plan).should == @plan
      end
      it "should find and assign a new purchase" do
        get :new, :user_id => @user.id, :plan_id => @plan.id
        assigns(:purchase).should be_a_new(Purchase)
      end
    end
  end

  describe "POST create" do
    before(:each) do
      sign_in(@user)
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
      Purchase.create(:plan_id => @plan2.id,
                      :user_id => @user.id,
                      :expired => false,
                      :period_end => Time.now() + 1.years,
                      :agreed_to_terms => true
                      )
      @downgrade = {:plan_id => @plan1.id,
              :user_id => @user.id,
              :expired => false,
              :agreed_to_terms => true
      }
    end
    it "should set and save period_end" do
      post :create, :user_id => @user.id, :purchase => @attr
      assigns(:purchase).period_end.should_not be_nil
    end
    context "with valid attributes" do
      it "should set the user's current purchase to what was just purchased" do
        post :create, :user_id => @user.id, :purchase => @attr
        @user.reload
        @user.current_purchase.should == assigns(:purchase).id
      end
      it "should send an email to the admin"
      it "should redirect to content_files_url" do
        post :create, :user_id => @user.id, :purchase => @attr
        response.should redirect_to content_files_url
      end
    end
    context "with invalid attributes" do
      it "should not save a new purchase to database" do
        expect{
          post :create, :user_id => @user.id, :purchase => @downgrade
        }.to_not change(Purchase, :count)
      end
      it "should assign a plan variable" do
        #try to purchase a downgrade should fail
        post :create, :user_id => @user.id, :purchase => @downgrade
        assigns(:plan).should == @plan1
      end
      it "should render new template with errors" do
        Purchase.create(:plan_id => @plan1.id,
                        :user_id => @user.id,
                        :expired => false,
                        :agreed_to_terms => true
                        )
        post :create, :user_id => @user.id, :purchase => @downgrade
        response.should render_template :new
      end
    end

  end

  describe "GET index" do
    before(:each) do
      sign_in(@user)
    end

    it "should render index" do
      get :index, :user_id => @user.id
      response.should render_template :index
    end

    it "should assign an array of user's purchases" do
      @purchase = Purchase.create(@attr)
      get :index, :user_id => @user.id
      assigns(:purchases).should == [@purchase]
    end
  end

  describe "PUT current_purchase" do
    before(:each) do
      sign_in(@user)
      @plan1 = Plan.create(:name => '5/month',
                          :price => 500,
                          :genre => 'Annual Subscription',
                          :downloads_per => 'month',
                          :max_downloads => 5
                          )
      @plan2 = Plan.create(:name => '10/year',
                          :price => 500,
                          :genre => 'A la Carte',
                          :downloads_per => 'year',
                          :max_downloads => 10
                          )
      @purchase1 = Purchase.create(:plan_id => @plan1.id,
                      :user_id => @user.id,
                      :expired => false,
                      :period_end => Time.now() + 1.years,
                      :agreed_to_terms => true
                      )
      @purchase2 = Purchase.create(:plan_id => @plan2.id,
                      :user_id => @user.id,
                      :expired => false,
                      :period_end => Time.now() + 1.years,
                      :agreed_to_terms => true
                      )
    end
    it "should assign the user" do 
      put :current_purchase, :user_id => @user.id, :purchase_id => @purchase2.id
      assigns(:user).should == @user
    end
    it "should find and assign the purchase to an instance variable" do 
      put :current_purchase, :user_id => @user.id, :purchase_id => @purchase2.id
      assigns(:purchase).should == @purchase2
    end
    it "should set user current purchase to purchase sent in via params" do
      @user.current_purchase = @purchase1.id
      @user.save
      put :current_purchase, :user_id => @user.id, :purchase_id => @purchase2.id
      @user.reload
      @user.current_purchase.should == @purchase2.id
    end
    it "should redirect to user purchases url" do
      put :current_purchase, :user_id => @user.id, :purchase_id => @purchase2.id
      response.should redirect_to user_purchases_url
    end

  end

end

