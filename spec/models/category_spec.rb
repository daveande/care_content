require 'spec_helper'

describe Category do
  before(:each) do
    @attr = {:name => 'foobar'}
  end

  it "should create an instance with valid attributes" do
    Category.create!(@attr)
  end

  it "should have a name attribute" do
    no_category_name = Category.new(@attr.merge(:name => ''))
    no_category_name.should_not be_valid
  end

  it "should respond to tags and content_files" do
    @category = Category.create!(@attr)
    @content_file = FactoryGirl.create(:content_file)
    @tag = Tag.create(:category_id => @category.id,
                      :content_file_id => @content_file.id
                     )
    @category.tags.should == [@tag]
    @category.content_files.should == [@content_file]
  end

end
