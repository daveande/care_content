class ChangeColumnTypeToGenreForPlans < ActiveRecord::Migration
  def up
    rename_column :plans, :type, :genre
  end

  def down
    rename_column :plans, :genre, :type
  end
end
