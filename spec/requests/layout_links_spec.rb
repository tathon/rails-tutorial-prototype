require 'spec_helper'

describe "LayoutLinks" do
	it "should have a Home page at '/'" do
		get '/'
		response.should have_selector("title", :content => "Home")
	end
	
	describe "when not signed in" do
		it "should have a signin link" do
			visit root_path
			response.should have_selector("a",	:href => signin_path,
																					:content => "Sign in")
		end
	end
	
	describe "when signed in" do
		before(:each) do
			@user = Factory(:user)
			visit signin_path
			fill_in :userid,		:with => @user.userid
			fill_in :password,	:with => @user.password
			click_button
		end
		
		it "should have a signout link" do
			visit root_path
			response.should have_selector("a",	:href => signout_path,
																					:content => "Sign out")
		end
		
		it "should have a PS451 link" do
			visit root_path
			response.should have_selector("a",	:href => '/ps451',
																					:content => "PS451")
		end
		    
    it "should have a right title for page 'PS451'" do
    	visit ps451_path
    	response.should have_selector("title", :content => "Rails Tutorial Prototype | PS451")
    end
	end
end
