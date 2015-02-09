class Post < ActiveRecord::Base
	# dependent: :destroy will delete all comments associated with a deleted post
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: {minimum: 5}

end
