require 'spec_helper'

describe User do
  before { @user = User.new(:email => "daveande@gmail.com", 
                            :first_name => "David",
                            :last_name => "Anderson",
                            :role => "admin",
                            :hospital_id => 2
                           )
           @hospital = Hospital.new(:id => 2, :name => "detroit hospital")
  }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:role) }

  describe 'when email is not present' do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe 'when password is not present' do
    before { @user.password = " " }
    it { should_not be_valid }
  end

  describe 'belong to a hospital' do
    before { @user.hospital }
    it { should be_valid }
  end
end
