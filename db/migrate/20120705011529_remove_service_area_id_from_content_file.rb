class RemoveServiceAreaIdFromContentFile < ActiveRecord::Migration
  def up
    remove_column :content_files, :service_area_id
  end

  def down
    add_column :content_files, :service_area_id, :integer
  end
end
