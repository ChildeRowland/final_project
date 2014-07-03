class CreateFollowingsTable < ActiveRecord::Migration
  def change
  	create_table :followings do |t|
  		t.integer :user_id
  		t.integer :f_id
  	end
  end
end
