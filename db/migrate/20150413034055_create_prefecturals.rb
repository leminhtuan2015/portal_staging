class CreatePrefecturals < ActiveRecord::Migration
  def change
    create_table :prefecturals do |t|
      t.string "name"
      t.timestamps null: false
    end
    add_index :prefecturals, :name
  end
end
