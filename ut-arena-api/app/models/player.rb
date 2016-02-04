class Player < ActiveRecord::Base
  validates :nick, presence: true

  has_many :player_games
  has_many :games, through: :player_games
end
