class ReportsController < ApplicationController
	before_filter :authenticate, :only => [:ps451]
	
  def ps451
  	@title = "PS451"
  end
  
  private
  	def authenticate
  		deny_access unless signed_in?
  	end
end
