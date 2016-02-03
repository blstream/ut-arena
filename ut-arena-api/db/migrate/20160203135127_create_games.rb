class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.timestamp :start_date
      t.integer :time_limit
      t.string :map_name
      t.string :match_type
      t.timestamps null: false
    end
  end
end
