ActiveAdmin.register ContentFile do
  index do
    column :title
    column :description
    column "Categories" do |content_file|
      content_file.categories.collect(&:name).join(', ') 
    end
    column "Word File" do |content_file|
      if !content_file.word_file.to_s.nil?
        link_to "Download", admin_download_file_url(:id => content_file.id, :type => "word")
      end
    end
    column "DreamWeaver File" do |content_file|
      if !content_file.dreamweaver_file.to_s.nil?
        link_to "Download", admin_download_file_url(:id => content_file.id, :type => "dreamweaver")
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
     row "Word File" do |f|
       unless f.word_file.to_s == nil
        url = f.word_file.to_s
        url = URI.parse(url)
        url.path
       end
     end
     row "Dreamweaver File" do |f|
       unless f.dreamweaver_file.to_s == nil
        url = f.dreamweaver_file.to_s
        url = URI.parse(url)
        url.path
       end
     end
     row :created_at
     row :updated_at
   end 
  end

  controller do 
    def admin_download_file
      @content_file = ContentFile.find(params[:id])
      if params[:type] == "word"
        if @content_file.word_file.to_s.nil?
          flash[:notice] = "This file cannot be downloaded"
        else
          redirect_to @content_file.word_file_url.to_s
        end
      elsif params[:type] == "dreamweaver"
        if @content_file.dreamweaver_file.to_s.nil?
          flash[:notice] = "This file cannot be downloaded"
        else
          redirect_to @content_file.dreamweaver_file_url.to_s
        end
      else
        flash[:notice] = "There was a problem downloading the file"
        redirect_to content_files_url
      end

    end
  end
  
end
