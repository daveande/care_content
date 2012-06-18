class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :content_file_id
      t.integer :category_id

      t.timestamps
    end
  end
end
