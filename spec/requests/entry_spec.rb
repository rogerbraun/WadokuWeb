describe Entry do

  before(:each) do
    1.upto(10) do 
      Factory(:entry)
    end
  end

  it "should not be editable by unregistered users" do
    lambda { visit edit_entry_path(Entry.first) }.should raise_error(CanCan::AccessDenied)

  end

  it "should be editable by registered users" do
    user = Factory(:user, :password => "something")

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "something"
    click_on "Sign in" 

    lambda { visit edit_entry_path(Entry.first) }.should_not raise_error(CanCan::AccessDenied)
  end

end
