require 'spec_helper'
include ActionDispatch::TestProcess

describe ContentFile do
  before(:each) do
    @word_file = fixture_file_upload( '/content_files/terms.docx', 'application/msword .docx')
    @attr = {:title => 'Sample',
             :description => 'A sample document',
             :preview_text => 'Hello, this is a sample',
             :word_file => @word_file
            }

  end

  it "should save a new instance with valid attributes" do
    ContentFile.create!(@attr)
  end

  it "should require a title" do
    no_title = ContentFile.new(@attr.merge(:title => ''))
    no_title.should_not be_valid
  end
  
  it "should require a description" do
    no_description = ContentFile.new(@attr.merge(:description => ''))
    no_description.should_not be_valid
  end

  describe 'content file associations' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @content_file = ContentFile.create!(@attr)
      @plan = FactoryGirl.create(:plan)
      @purchase = Purchase.create(:plan_id => @plan.id,
                                  :user_id => @user.id,
                                  :period_end => Time.now() + 1.years,
                                  :expired => false,
                                  :agreed_to_terms => true
                                )
      @user.current_purchase = @purchase.id
      @user.save
      @category = FactoryGirl.create(:category)
      @category1 = FactoryGirl.create(:category)
      @tag = Tag.create(:category_id => @category.id,
                        :content_file_id => @content_file.id
                       )
      @tag1 = Tag.create(:category_id => @category1.id,
                        :content_file_id => @content_file.id
                       )
      @download = Download.create(:user_id => @user.id,
                                  :content_file_id => @content_file.id,
                                  :service_area_id => @user.hospital.service_area.id,
                                  :purchase_id => @purchase.id
                                  )
    end

    it "should have many tags" do
      @content_file.tags.should == [@tag, @tag1]
    end
    
    it "should have many categories" do
      @content_file.categories.should == [@category, @category1]
    end

    it "should have many downloads" do
      @content_file.downloads.should == [@download]
    end
  end
end
