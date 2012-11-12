require 'spec_helper'

describe DownloadsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @content_file = ContentFile.create(
        :title => 'Sample',
        :description => 'A sample document',
        :preview_text => 'Hello, this is a sample',
        :word_file => fixture_file_upload('/content_files/terms.docx', 'application/msword .docx')
    )
    @plan = FactoryGirl.create(:plan)
    @purchase = Purchase.create(:plan_id => @plan.id,
                                :user_id => @user.id,
                                :period_end => Time.now() + 1.years,
                                :expired => false,
                                :agreed_to_terms => true
                               )
    @user.current_purchase = @purchase.id
    @user.save
  end

  it "should require a signed in user" do
    post :create, :content_file_id => @content_file
    response.should redirect_to new_user_session_url
  end

  describe "POST create" do
    before(:each) do
      sign_in(@user)
    end
    
    it "should find the right content_file" do
      post :create, :content_file_id => @content_file.id, :type => 'word', :count => 'true'
      assigns(:content_file).should == @content_file
    end

    context "with params[:count] set to false" do
      it "should redirect to content_file url if params[:count] is not true" do
        post :create, :content_file_id => @content_file.id, :type => 'word', :count => 'false'
        response.should redirect_to @content_file.word_file_url.to_s
      end

      it "should not create a new download" do
        expect{
          post :create, :content_file_id => @content_file.id, :type => 'word', :count => 'false'
        }.to_not change(Download, :count)
      end
    end

    context "with params[:count] set to true" do
      context "and a valid download" do
        it "should create a new download in the database" do
          expect{
            post :create, :content_file_id => @content_file.id, :type => 'word', :count => 'true'
          }.to change(Download, :count).by(1)
        end

        it "should redirect_to the content_file" do
          post :create, :content_file_id => @content_file.id, :type => 'word', :count => 'true'
          response.should redirect_to @content_file.word_file_url.to_s
        end
      end
      context "with an invalid download" do
        it "should render errors and redirect_to content_files_url" do
          @user.current_purchase = nil
          @user.save
          post :create, :content_file_id => @content_file.id, :type => 'word', :count => 'true'
          response.should redirect_to content_files_url
        end
        it "should not save a new download in database" do
          @user.current_purchase = nil
          @user.save
          expect{
            post :create, :content_file_id => @content_file.id, :type => 'word', :count => 'true'
          }.to_not change(Download, :count)
        end
      end
    end


  end
end
