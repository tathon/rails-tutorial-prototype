require 'spec_helper'

describe PagesController do
	render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have a right title" do
    	get 'home'
    	response.should have_selector("title", :content => "Rails Tutorial Prototype | Home")
    end
  end

  describe "GET 'ps451'" do
    it "should be successful" do
      get 'ps451'
      response.should be_success
    end
    
    it "should have a right title" do
    	get 'ps451'
    	response.should have_selector("title", :content => "Rails Tutorial Prototype | PS451")
    end
  end

end
