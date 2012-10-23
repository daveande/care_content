class AddPurchaseIdToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :purchase_id, :integer
  end
end
