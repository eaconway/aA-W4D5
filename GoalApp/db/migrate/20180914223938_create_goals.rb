class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :goal, null: false
      t.string :user_id, null: false
      t.string :state, null: false
      t.timestamps
    end
    
    add_index :goals, :user_id
  end
end
