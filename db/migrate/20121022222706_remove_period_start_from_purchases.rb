class RemovePeriodStartFromPurchases < ActiveRecord::Migration
  def up
    remove_column :purchases, :period_start
  end

  def down
    add_column :purchases, :period_start, :datetime
  end
end
