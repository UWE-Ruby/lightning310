class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :sudent_id
      t.string :title
      t.text :description
      t.date :proposed_date
      t.date :completed_date
      t.boolean :approved

      t.timestamps
    end
  end
end
