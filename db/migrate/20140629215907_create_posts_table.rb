class CreatePostsTable < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
		t.user_id :integer
		t.created :datetime
		t.blog_post :string
  	end
  end
end
