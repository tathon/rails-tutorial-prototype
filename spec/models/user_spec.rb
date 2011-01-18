require 'spec_helper'

describe User do
	before(:each) do
		@attr = {
			:name => "Test User",
			:userid => "testuser",
			:password => "foobar"
			}
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
	
	describe "password validations" do
		it "should require a password" do
			User.new(@attr.merge(:password => "")).should_not be_valid
		end
				
		it "should reject short password" do
			short = "a" * 1
			hash = @attr.merge(:password => short)
			User.new(hash).should_not be_valid		
		end
		
		it "should reject long passwords" do
			long = "a" * 11
			hash = @attr.merge(:password => long)
			User.new(hash).should_not be_valid
		end
	end
	
	describe "password encryption" do
		before(:each) do
			@user = User.create!(@attr)
		end
		
		it "should have an encrypted password attribute" do
			@user.should respond_to(:encrypted_password)
		end
		
		it "should set the encrypted password" do
			@user.encrypted_password.should_not be_blank
		end
		
		describe "has_password? method" do
			it "should be true if the password match" do
				@user.has_password?(@attr[:password]).should be_true
			end
			
			it "should be false if the password don't match" do
				@user.has_password?("invalid").should be_false
			end
		end
		
		describe "authenticate method" do
			it "should return nil on userid/password mismatch" do
				wrong_password_user = User.authenticate(@attr[:userid], "wrongpass")
				wrong_password_user.should be_nil
			end
			
			it "should return nil for an userid with no user" do
				nonexistent_user = User.authenticate("wronguser", @attr[:password])
				nonexistent_user.should be_nil
			end
			
			it "should return the user on userid/password match" do
				matching_user = User.authenticate(@attr[:userid], @attr[:password])
				matching_user.should == @user
			end
		end
	end
end
