class User < ActiveRecord::Base

	has_one :profile
	has_many :posts
	has_many :followings
	has_many :relationships
	has_many :user_followings, through: :relationships

end


class Post < ActiveRecord::Base

	belongs_to :user

end


class Profile < ActiveRecord::Base
	belongs_to :user
end


class Following < ActiveRecord::Base

	belongs_to :user

end


class UserFollowing < ActiveRecord::Base

	has_many :relationships
	has_many :users, through: :relationships
	
end


class Relationship < ActiveRecord::Base

	belongs_to :user
	belongs_to :user_following

end
