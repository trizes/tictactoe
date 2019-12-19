class SetGameBoardLimit < ActiveRecord::Migration[6.0]
  def change
    change_column :games, :board, :string, limit: 9
  end
end
