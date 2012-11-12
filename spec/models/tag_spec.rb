require 'spec_helper'

describe Tag do
  before(:each) do
    @content_file = FactoryGirl.create(:content_file)
    @category = FactoryGirl.create(:category)
    @attr = {:category_id => @category.id,
             :content_file_id => @content_file.id
            }
  end
  it "should create a new tag with valid attributes" do
    Tag.create!(@attr)
  end
  it "should respond to content_file" do
    tag = Tag.create!(@attr)
    tag.content_file.should == @content_file
  end
  it "should respond to category" do
    tag = Tag.create!(@attr)
    tag.category.should == @category
  end
end
