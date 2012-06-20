class AddWordFileToContentFile < ActiveRecord::Migration
  def change
    add_column :content_files, :word_file, :string
  end
end
