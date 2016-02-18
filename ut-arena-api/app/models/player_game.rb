# Player model Class
class PlayerGame < ActiveRecord::Base
  # Relations to the Player and Game models
  belongs_to :player, foreign_key: 'player_id'
  belongs_to :game, foreign_key: 'game_id'
end
