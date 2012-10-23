class AddPriceToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :price, :integer
  end
end
