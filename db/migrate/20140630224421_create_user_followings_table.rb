class CreateUserFollowingsTable < ActiveRecord::Migration
  def change

  	create_table :user_followings do |t|
  		t.string :fname
  		t.string :lname
  		t.string :email
  	end
  	
  end
end
