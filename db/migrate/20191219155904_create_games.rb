class CreateGames < ActiveRecord::Migration[6.0]
  def up
    create_table :games, id: :uuid do |t|
      t.string :board, default: '---------'
      t.integer :status, default: 0

      t.timestamps
    end
  end

  def down
    drop_table :games
  end
end
