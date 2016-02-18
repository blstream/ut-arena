# Require bcrypt gem
require 'bcrypt'

# User model Class
class User < ActiveRecord::Base
	# include BCrypt module in the User class
	include BCrypt

		# Validates if the login and email are not Null
  	validates :login, :email, presence: true
		# Validates if the email is a valid email address
  	validates :email, email: true

    # Public: Compares the password to the password_digest
  	def password
  		@password ||= Password.new(password_digest)
  	end

    # Public: Set new password
  	def password=(new_password)
  		@password = Password.create(new_password)
  		self.password_digest = @password
  	end

		# Public: generates authentication token and sets the expire date
		def generate_authentication_token
		  self.token_expires_at = Time.now + 1.days
      loop do
        self.authentication_token = SecureRandom.base64(64)
        break unless User.find_by(authentication_token: authentication_token)
      end
    end
end
