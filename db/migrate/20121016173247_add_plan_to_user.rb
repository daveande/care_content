class AddPlanToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_plan, :integer
  end
end
