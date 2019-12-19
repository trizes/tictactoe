class Game < ApplicationRecord
  STATUSES = {
    running: 'RUNNING',
    x_won: 'X_WON',
    o_won: 'O_WON',
    draw: 'DRAW'
  }.freeze

  enum status: STATUSES
end
