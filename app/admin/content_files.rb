ActiveAdmin.register ContentFile do
  index do
    column :title
    column :description
    column "Categories" do |content_file|
      content_file.categories.collect(&:name).join(', ') 
    end
    column "Word File" do |content_file|
      if !content_file.word_file.to_s.nil?
        link_to "Download", download_file_url(:id => content_file.id, :type => "word")
      end
    end
    column "DreamWeaver File" do |content_file|
      if !content_file.dreamweaver_file.to_s.nil?
        link_to "Download", download_file_url(:id => content_file.id, :type => "dreamweaver")
      end
    end
    column :service_area
    column "Downloads" do |content_file|
      if content_file.downloads.empty?
        "-"
      else
        link_to content_file.downloads.count, admin_downloads_url
      end
    end 
    default_actions
  end

  filter :service_area
  filter :title
  filter :description

  form :partial => "form"

  show do |content_file|
   attributes_table do
     row :title
     row :description
     row :preview_text
     row "Categories" do |f|
       f.categories.collect(&:name).join(', ')
     end
     row "Downloads" do |f|
       f.downloads.empty? ? '-' : f.downloads.count
     end
     row :service_area
     row :word_file
     row :dreamweaver_file
     row :created_at
     row :updated_at
     
   end 

  end

  
end
