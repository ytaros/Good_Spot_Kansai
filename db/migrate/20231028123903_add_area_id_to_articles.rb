class AddAreaIdToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :area_id, :integer
    add_index :articles, :area_id
    add_foreign_key :articles, :areas
  end
end
