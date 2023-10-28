class AddUniqueConstraintToArticleTags < ActiveRecord::Migration[7.0]
  def change
    add_index :article_tags, [:article_id, :tag_id], unique: true
  end
end
