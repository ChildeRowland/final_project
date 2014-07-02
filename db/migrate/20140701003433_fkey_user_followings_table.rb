class FkeyUserFollowingsTable < ActiveRecord::Migration
  def change
  	add_column :user_followings, :user_id, :integer
  end
end
