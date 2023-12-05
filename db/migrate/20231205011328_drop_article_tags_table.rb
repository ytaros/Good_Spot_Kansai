class DropArticleTagsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :article_tags
  end
end
