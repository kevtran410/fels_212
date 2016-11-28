class AddScoreToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :score, :integer
  end
end
