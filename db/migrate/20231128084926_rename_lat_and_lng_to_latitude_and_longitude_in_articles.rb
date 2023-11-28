class RenameLatAndLngToLatitudeAndLongitudeInArticles < ActiveRecord::Migration[7.0]
  def change
    rename_column :articles, :lat, :latitude
    rename_column :articles, :lng, :longitude
  end
end
