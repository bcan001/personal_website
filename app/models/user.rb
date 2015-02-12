class User < ActiveRecord::Base
	# the class User inherits from ActiveRecord::Base (User model has all its functionality)

	# presence: true is an options hash, validates is a method

	validates :name,  presence: true, length: { maximum: 50 }

	# an email is valid only if it matches the VALID_EMAIL_REGEX format
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

end
