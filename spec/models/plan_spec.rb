require 'spec_helper'

describe Plan do
  before(:each) do
    @attr = {:name => '2/year',
             :price => 500,
             :genre => 'A la Carte',
             :downloads_per => 'year',
             :max_downloads => 2
            }
  end
  it "should create a new instance with valid attributes" do
    Plan.create!(@attr)
  end
  it "should require max_downloads" do
    no_max = Plan.new(@attr.merge(:max_downloads => nil))
    no_max.should_not be_valid
  end
  it "should require downloads_per" do
    no_downloads_per = Plan.new(@attr.merge(:downloads_per => nil))
    no_downloads_per.should_not be_valid
  end
  describe "downloads_per validation" do
    it "should allow downloads_per year" do
      downloads_per_year = Plan.new(@attr.merge(:downloads_per => 'year'))
      downloads_per_year.should be_valid
    end
    it "should allow downloads_per month" do
      downloads_per_month = Plan.new(@attr.merge(:downloads_per => 'month'))
      downloads_per_month.should be_valid
    end
    it "should reject invalid downloads_per strings" do
      strings = ['monthly', 'yearly', 'semi-annually']
      strings.each do |string|
        invalid_downloads_per = Plan.new(@attr.merge(:downloads_per => string))
        invalid_downloads_per.should_not be_valid
      end
    end
  end
  it "should require price" do
    no_price = Plan.new(@attr.merge(:price => nil))
    no_price.should_not be_valid
  end
  it "should require genre" do
    no_genre = Plan.new(@attr.merge(:genre => nil))
    no_genre.should_not be_valid
  end
  describe "genre validation" do
    it "should allow genre a la carte" do
      alacarte_genre = Plan.new(@attr.merge(:genre => 'A la Carte'))
      alacarte_genre.should be_valid
    end
    it "should allow genre annual subscription" do
      subscription_genre = Plan.new(@attr.merge(:genre => 'Annual Subscription'))
      subscription_genre.should be_valid
    end
    it "should reject invalid genre strings" do
      strings = ['monthly', 'yearly', 'semi-annually']
      strings.each do |string|
        invalid_genre = Plan.new(@attr.merge(:genre => string))
        invalid_genre.should_not be_valid
      end
    end
  end
  it "should require a name" do
    no_name = Plan.new(@attr.merge(:name => nil))
    no_name.should_not be_valid
  end
end
