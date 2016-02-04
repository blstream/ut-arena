class PlayerGame < ActiveRecord::Base
  belongs_to :player, :foreign_key => 'player_id'
  belongs_to :game, :foreign_key => 'game_id'
end
