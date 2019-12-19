class CreateGames < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE game_status AS ENUM ('RUNNING', 'X_WON', 'O_WON', 'DRAW');
    SQL

    create_table :games, id: :uuid do |t|
      t.string :board, default: ''
      t.column :status, :game_status, default: 'RUNNING'

      t.timestamps
    end
  end

  def down
    drop_table :games, :status

    execute <<-SQL
      DROP TYPE game_status;
    SQL
  end
end
