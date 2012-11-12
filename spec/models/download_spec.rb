require 'spec_helper'

describe Download do
  before(:each) do
    @content_file = FactoryGirl.create(:content_file)
    @plan = FactoryGirl.create(:plan)
    @user = FactoryGirl.create(:user)
    @purchase = Purchase.create(:plan_id => @plan.id,
                                :user_id => @user.id,
                                :period_end => Time.now() + 1.years,
                                :expired => false,
                                :agreed_to_terms => true
                               )
    @user.current_purchase = @purchase.id
    @user.save
    @attr = {:content_file_id => @content_file.id,
             :user_id => @user.id,
             :service_area_id => @user.hospital.service_area.id,
             :purchase_id => @purchase.id
            }
  end

  it "should create an instance with valid attributes" do
    Download.create!(@attr)
  end

  describe "associations" do
    before(:each) do
      @download = Download.create!(@attr)
    end
    it "should belong to content_file" do
      @download.content_file.should == @content_file
    end
    it "should belong to service area" do
      @download.service_area.should == @user.hospital.service_area
    end
    it "should belong to user" do
      @download.user.should == @user
    end
    it "should belong to a purchase" do
      @download.purchase.should == @purchase
    end
  end

  describe "validations" do
    it "should validate uniqueness of user_id and content_file_id" do
      download = Download.create!(@attr)
      duplicate_download = Download.new(@attr)
      duplicate_download.should_not be_valid
    end
    context "user without current_purchase" do
      it "should not create a download" do
        @user.current_purchase = nil
        @user.save
        no_current_purchase = Download.create(@attr)
        no_current_purchase.errors.messages.should == {:user => ["does not have any available downloads. Please purchase a download or subscription plan."]}
      end
    end
    context "user with zero purchases" do
      it "should not create a download" do
        no_purchase = Download.create(@attr)
        #stub out methods in if/or statement from download.rb
        no_purchase.stub(:user => double(:current_purchase => 1,
                                         :purchases => nil))
        no_purchase.should_not be_valid
        no_purchase.errors.messages.should == {:user => ["does not have any available downloads. Please purchase a download or subscription plan."]}
      end
    end
    context "user without a non expired purchase" do
      it "should not create a download" do
        expired_purchase = Download.create(@attr)
        #stub out methods in if/or statement from download.rb
        expired_purchase.stub(:user => double(:current_purchase => 1,
                                              :purchases => double(:nil? => false, :where => [])))
        expired_purchase.should_not be_valid
        expired_purchase.errors.messages.should == {:user => ["does not have any available downloads. Please purchase a download or subscription plan."]}
      end
    end
    it "should validate that user has an available download" do
      #factory girl plan has 2/year; should fail if download.count >= plan downloads (2)
      download1 = Download.create(@attr)
      content_file2 = FactoryGirl.create(:content_file)
      content_file3 = FactoryGirl.create(:content_file)
      download2 = Download.create(@attr.merge(:content_file_id => content_file2.id))
      download3 = Download.new(@attr.merge(:content_file_id => content_file3.id))
      download3.should_not be_valid
      download3.errors.messages.should == {:user => ["has exceeded purchased downloads for this plan. Please change your selected plan, purchase additional downloads, or upgrade your subscription."]} 
    end
    
  end

end
