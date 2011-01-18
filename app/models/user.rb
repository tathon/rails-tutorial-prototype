# == Schema Information
# Schema version: 20110118023256
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  userid     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
	attr_accessible :name, :userid
	
	validates :name, 	:presence => true,
										:length => { :maximum => 30 }
	validates :userid,	:presence => true,
											:length => { :maximum => 10 },
											:uniqueness => { :case_sensitive => false }
	
end
