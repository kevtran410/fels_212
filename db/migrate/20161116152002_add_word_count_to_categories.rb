class AddWordCountToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :word_count, :integer
  end
end
