Game.create!([
  { id: 1, start_date: "2016-01-01", time_limit: 10, map_name: "Prague v2", match_type: "Free for All" },
  { id: 2, start_date: "2016-01-02", time_limit: 14, map_name: "Herring", match_type: "Free for All" },
  { id: 3, start_date: "2016-03-01", time_limit: 20, map_name: "Prague v2", match_type: "Team Deathmatch" },
  { id: 4, start_date: "2016-04-01", time_limit: 50, map_name: "Prague v2", match_type: "Free for All" },
])
Player.create!([
  { id: 1, nick: 'krzyszti' },
  { id: 2, nick: 'lukasz' }
])
User.create!([
  { login: "test2", email: "test2@ut-arena.com", password_digest: "$2a$10$t.LTX.EIjzDRZcWJR.Wi1epOH0gz7Omx8vTFC5g7UVxF1ZTtsfMVe" },
  { login: "test", email: "test@ut-arena.com", password_digest: "$2a$10$v7/xlEAdUwsB8Yo2RQswnOeAElkfE2Pzu7q6VCIaIe0yqGLIECNPO" }
])
PlayerGame.create!([
  { game_id: 1, player_id: 1, score: 40 },
  { game_id: 1, player_id: 2, score: 30 },
  { game_id: 2, player_id: 1, score: 31 },
  { game_id: 2, player_id: 2, score: 41 }
])
