class ReplaceGoalTitle < ActiveRecord::Migration[5.2]
  def change
    remove_column :goals, :goal
    
    add_column :goals, :title, :string
  end
end
