class AddAgreeToTermsToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :agreed_to_terms, :boolean
  end
end
