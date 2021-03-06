# == Schema Information
# Schema version: 20110118031141
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  userid             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :name, :userid, :password
	
	validates :name, 			:presence => true,
												:length => { :maximum => 30 }
	validates :userid,		:presence => true,
												:length => { :maximum => 10 },
												:uniqueness => { :case_sensitive => false }
	validates :password, 	:presence => true,
												:length => { :within => 2..10 }
												
	before_save :encrypt_password
	
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	
	def self.authenticate(userid, submitted_password)
		user = find_by_userid(userid)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end
	
	private
		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end
		
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
