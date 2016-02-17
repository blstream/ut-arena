json.id @game.id
json.start_date @game.start_date
json.time_limit @game.time_limit
json.map_name @game.map_name
json.match_type @game.match_type
json.players @game.players do |player|
  json.id player.id
  json.nick player.nick
  json.score player.player_games.where(game_id: @game.id).first.score
  json.team player.player_games.where(game_id: @game.id).first.team
end
