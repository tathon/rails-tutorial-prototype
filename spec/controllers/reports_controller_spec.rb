require 'spec_helper'

describe ReportsController do
	render_views

	describe "authentication of PS451 page" do
		before(:each) do
			@user = Factory(:user)
		end
		
		describe "for non-signed-in users" do
			it "should deny access to 'PS451'" do
				get 'ps451', :id => @user
				response.should redirect_to(signin_path)
			end
		end
	end
end
