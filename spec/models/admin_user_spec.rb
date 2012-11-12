require 'spec_helper'

describe AdminUser do
  before(:each) do
    @attr = {:email => "daveande@gmail.com", 
             :password => 'foobar',
             :password_confirmation => 'foobar'
            }
  end

  it "should create a new instance given valid attributes" do
    AdminUser.create!(@attr)
  end

  it "should require an email" do
    no_email = AdminUser.new(@attr.merge(:email => ''))
    no_email.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = AdminUser.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = AdminUser.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    AdminUser.create!(@attr)
    user_with_duplicate_email = AdminUser.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    AdminUser.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = AdminUser.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do

    before(:each) do
      @admin_user = AdminUser.new(@attr)
    end

    it "should have a password attribute" do
      @admin_user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @admin_user.should respond_to(:password_confirmation)
    end

  end
  
  describe "password validations" do

    it "should require a password" do
      AdminUser.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      AdminUser.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      AdminUser.new(hash).should_not be_valid
    end
    
  end

end
