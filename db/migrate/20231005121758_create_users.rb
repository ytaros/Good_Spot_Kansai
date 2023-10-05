class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :crypted_password
      t.string :avatar
      t.integer :role
      t.references :prefecture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
