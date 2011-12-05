require 'spec_helper'

describe User do
  it "should create users" do
    User.count.should == 0
    user = Factory(:user)
    User.count.should == 1
  end
end
