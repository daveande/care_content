class AddIndexToModels < ActiveRecord::Migration
  def change
    add_index :downloads, :user_id
    add_index :downloads, :content_file_id
    add_index :hospitals, :service_area_id
    add_index :users, :hospital_id
    add_index :tags, :category_id
    add_index :tags, :content_file_id
  end
end
