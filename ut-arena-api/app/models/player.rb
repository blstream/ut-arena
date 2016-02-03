class Player < ActiveRecord::Base
  validates :nick, presence: true
end
