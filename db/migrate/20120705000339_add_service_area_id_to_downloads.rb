class AddServiceAreaIdToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :service_area_id, :integer
  end
end
