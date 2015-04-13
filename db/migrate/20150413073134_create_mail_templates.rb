class CreateMailTemplates < ActiveRecord::Migration
  def change
    create_table :mail_templates do |t|
      t.string "name"
      t.string "subject"
      t.text "text"

      t.timestamps null: false
    end
    add_index :mail_templates, :name, unique: true
  end
end
