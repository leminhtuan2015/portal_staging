class CreateSeminers < ActiveRecord::Migration
  def change
    create_table :seminers do |t|
      t.string :title
      t.string :place
      t.datetime :date_time

      t.timestamps
    end
  end
end
