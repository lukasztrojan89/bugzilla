class RemoveHighScores < ActiveRecord::Migration
  def change
  drop_table :high_scores
  end
end
