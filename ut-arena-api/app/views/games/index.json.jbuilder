json.games @games do |game|
  json.id game.id
  json.start_date game.start_date
  json.time_limit game.time_limit
  json.map_name game.map_name
  json.match_type game.match_type
end
