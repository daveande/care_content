ActiveAdmin.register ContentFile do
  index do
    column :title
    column :description
    column :service_area
    column "Categories" do |content_file|
      content_file.categories.collect(&:name).join(', ') 
    end
    column "Word File" do |content_file|
      if !content_file.word_file.to_s.nil?
        link_to "Download", download_file_url(:id => content_file.id)
      end
    end
    column "DreamWeaver File" do |content_file|
      if !content_file.dreamweaver_file.to_s.nil?
        link_to "Download", download_file_url(:id => content_file.id)
      end
    end
    default_actions
  end

  filter :service_area
  filter :title
  filter :description

  form do |f|
    f.inputs do
        f.input :title, :required => true
        f.input :description
        f.input :categories, :as => :check_boxes
        f.input :word_file, :as => :file, :hint => "must be a .doc or .docx file"
        f.input :dreamweaver_file, :as => :file, :hint => "must be a .htm file"
    end
      f.buttons
  end

  
end
