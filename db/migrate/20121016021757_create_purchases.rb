class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :plan_id
      t.integer :user_id
      t.datetime :period_start
      t.datetime :period_end
      t.boolean :expired, :default => false

      t.timestamps
    end
  end
end
