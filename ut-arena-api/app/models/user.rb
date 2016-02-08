class User < ActiveRecord::Base
  validates :login, :email, presence: true
  validates :email, email: true
  has_secure_password

end
