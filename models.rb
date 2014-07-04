class User < ActiveRecord::Base

	has_one :profile
	has_many :posts
	has_many :relationships, foreign_key: :follower_id
	has_many :followed, through: :relationships, source: :followed

	has_many :reverse_relationships, foreign_key: :followed_id, class_name: "Relationship"
	has_many :followers, through: :reverse_relationships, source: :follower
	# has_many :followings, foreign_key: "f_id"
	# has_many :followed_users, through: :followings, source: :followed
	# has_many :
	# has_many :followers, foreign_key: "user_id"
	# has_many 
	# has_many :relationships
	# has_many :user_followings, through: :relationships

end

class Relationship < ActiveRecord::Base

	# belongs_to :user
	# belongs_to :user_following
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"
end

class Following < ActiveRecord::Base

	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"

end


class UserFollowing < ActiveRecord::Base

	has_many :relationships
	has_many :users, through: :relationships
	
end


class Post < ActiveRecord::Base

	belongs_to :user

end


class Profile < ActiveRecord::Base
	belongs_to :user
end



# class Following < ActiveRecord::Base

# 	belongs_to :follower, class_name: "User"
# 	belongs_to :followed, class_name: "User"

# end


# class UserFollowing < ActiveRecord::Base

# 	has_many :relationships
# 	has_many :users, through: :relationships
	
# end
