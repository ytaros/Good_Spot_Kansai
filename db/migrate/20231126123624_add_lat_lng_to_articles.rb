class AddLatLngToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :lat, :float
    add_column :articles, :lng, :float
  end
end
