json.games @games do |game|
  json.id game.id
  json.start_date game.start_date
  json.time_limit game.time_limit
  json.map_name game.map_name
  json.match_type game.match_type
  json.score do
    json.score game.player_games.where(player_id: @player.id).first.score
    json.team game.player_games.where(player_id: @player.id).first.team
  end
end
