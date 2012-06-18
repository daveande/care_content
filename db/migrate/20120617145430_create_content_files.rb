class CreateContentFiles < ActiveRecord::Migration
  def change
    create_table :content_files do |t|
      t.string :title
      t.text :description
      t.integer :service_area_id

      t.timestamps
    end
  end
end
