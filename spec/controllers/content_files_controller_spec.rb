require 'spec_helper'

describe ContentFilesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @word_file = fixture_file_upload( '/content_files/terms.docx', 'application/msword .docx')
    @attr = {:title => 'Sample',
            :description => 'A sample document',
            :preview_text => 'Hello, this is a sample',
            :word_file => @word_file
            }
  end

  it "should not show without a logged in user" do
    get :index
    response.should redirect_to new_user_session_url
  end

  describe "GET 'index'" do
    it "returns http success" do
      sign_in(@user)
      get 'index'
      response.should be_success
    end
    
    it "assigns a title to @title" do
      sign_in(@user)
      get 'index'
      assigns(:title).should == "Content | CareContent"
    end

  end

end
