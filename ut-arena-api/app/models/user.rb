require 'bcrypt'

class User < ActiveRecord::Base
	include BCrypt

  	validates :login, :email, presence: true
  	validates :email, email: true

  	def password
  		@password ||= Password.new(password_digest)
  	end

  	def password=(new_password)
  		@password = Password.create(new_password)
  		self.password_digest = @password
  	end

		def generate_authentication_token
      loop do
        self.authentication_token = SecureRandom.base64(64)
        break unless User.find_by(authentication_token: authentication_token)
      end
    end
end
