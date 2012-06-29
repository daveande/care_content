class AddPreviewTextToContentFiles < ActiveRecord::Migration
  def change
    add_column :content_files, :preview_text, :text
  end
end
