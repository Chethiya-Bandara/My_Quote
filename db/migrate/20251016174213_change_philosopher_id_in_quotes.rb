# Purpose: Change the null: false value in quotes -> philosopher_id into null: true.

class ChangePhilosopherIdInQuotes < ActiveRecord::Migration[8.0]
  def change
    change_column_null :quotes, :philosopher_id, true
  end
end
