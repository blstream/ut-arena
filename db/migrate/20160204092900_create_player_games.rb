class CreatePlayerGames < ActiveRecord::Migration
  def change
    create_table :player_games do |t|
      t.belongs_to :game, index: true
      t.belongs_to :player, index: true
      t.integer :score
      t.integer :team
      t.timestamps null: false
    end
  end
end
