class Game < ActiveRecord::Base
    has_many :player_games
    has_many :players, through: :player_games

    # This method returns true if the game end time has passed.
    def is_finished?
      (self.start_date + self.time_limit.minutes) < Time.now
    end
end
