require 'spec_helper'

describe User do
	before(:each) do
		@attr = { :name => "Test User", :userid => "testuser" }
	end

	it "should create a new instance given valid attributes" do
		User.create!(@attr)
	end
	
	it "should require a name" do
		no_name_user = User.new(@attr.merge(:name => ""))
		no_name_user.should_not be_valid
	end
	
	it "should require an userid" do
		no_userid_user = User.new(@attr.merge(:userid => ""))
		no_userid_user.should_not be_valid
	end
	
	it "should reject names that are too long" do
		long_name = "a" *31
		long_name_user = User.new(@attr.merge(:name => long_name))
		long_name_user.should_not be_valid
	end
	
	it "should reject userid that are too long" do
		long_userid = "a" *11
		long_userid_user = User.new(@attr.merge(:userid => long_userid))
		long_userid_user.should_not be_valid
	end
	
	it "should reject duplicated userid" do
		upcased_userid = @attr[:userid].upcase
		User.create!(@attr.merge(:userid => upcased_userid))
		user_with_duplicated_userid = User.new(@attr)
		user_with_duplicated_userid.should_not be_valid
	end
end
