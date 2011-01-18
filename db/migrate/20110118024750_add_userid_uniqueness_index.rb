class AddUseridUniquenessIndex < ActiveRecord::Migration
  def self.up
  	add_index :users, :userid, :unique => true
  end

  def self.down
  	remove_index :users, :userid
  end
end
