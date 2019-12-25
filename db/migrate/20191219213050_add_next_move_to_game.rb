class AddNextMoveToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :next_move, :integer, default: 0
  end
end
