class ChangeColumnNameCurrentPlanToCurrentPurchaseForUsers < ActiveRecord::Migration
  def up
    rename_column :users, :current_plan, :current_purchase
  end

  def down
    rename_column :users, :current_purchase, :current_plan
  end
end
