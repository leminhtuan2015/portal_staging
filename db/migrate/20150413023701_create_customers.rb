class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :company
      t.string :family_name
      t.string :first_name
      t.string :tel
      t.string :password
      t.string :postal_code
      t.integer :prefectural_id
      t.string :city
      t.string :street
      t.string :building
      t.string :siteurl
      t.date :birthday
      t.integer :sex
      t.boolean :mailmagazine_accepted
      t.string :facebook_id

      t.timestamps
    end
    add_index :customers, :prefectural_id
  end
end
