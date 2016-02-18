# Player model Class
class Player < ActiveRecord::Base
  # Validates if the nick is not Null
  validates :nick, presence: true

  # Relations to the Games and PlayerGames model
  has_many :player_games
  has_many :games, through: :player_games
end
