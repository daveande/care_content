class AddDreamWeaverFileToContentFile < ActiveRecord::Migration
  def change
    add_column :content_files, :dreamweaver_file, :string
  end
end
