#encoding: utf-8
require "spec_helper"

describe Entry do

  it "should be versioned" do

    entry = Factory(:entry)
    entry.versions.size.should == 1
    entry.romaji = "something else"
    entry.save
    entry.versions.size.should == 2

  end

end
