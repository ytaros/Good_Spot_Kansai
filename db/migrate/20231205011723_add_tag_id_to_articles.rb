class AddTagIdToArticles < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :tag, foreign_key: true
  end
end
