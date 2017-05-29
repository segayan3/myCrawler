class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest

      t.timestamps null: false
      
      t.index :name, unique: true # name検索の高速化とユニーク化
    end
  end
end
