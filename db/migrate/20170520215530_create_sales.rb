class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :site_name
      t.string :url
      t.string :staff_name
      t.string :email
      t.string :address
      t.string :phone_number

      t.timestamps null: false
      
      t.index :email
    end
  end
end
