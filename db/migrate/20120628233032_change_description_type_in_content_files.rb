class ChangeDescriptionTypeInContentFiles < ActiveRecord::Migration
  def up
    change_column :content_files, :description, :string
  end

  def down
    change_column :content_files, :description, :text
  end
end
