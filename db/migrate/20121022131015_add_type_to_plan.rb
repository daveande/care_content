class AddTypeToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :type, :string
  end
end
