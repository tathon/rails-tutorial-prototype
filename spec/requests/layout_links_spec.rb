require 'spec_helper'

describe "LayoutLinks" do
	it "should have a Home page at '/'" do
		get '/'
		response.should have_selector("title", :content => "Home")
	end

	it "should have a PS451 page at '/ps451'" do
		get '/ps451'
		response.should have_selector("title", :content => "PS451")
	end
end
