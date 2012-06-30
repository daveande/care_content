class ContentFilesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @your_downloads = ContentFile.joins(:downloads).where(:downloads => {:user_id => current_user.id})

    if Rails.env.production?
      content_files_filtered = ContentFile.where('service_area_id is ? OR service_area_id <> ?', nil, current_user.hospital.service_area_id)
    else
      content_files_filtered = ContentFile.where('service_area_id is not ?', current_user.hospital.service_area_id)
    end

    if params[:category]
      @category = params[:category]
      puts "category is #{@category}"
      @content_files = content_files_filtered.joins(:categories).where(:categories => {:id => params[:category]})
    else
      @category = 'all'
      @content_files = content_files_filtered 
    end
    @categories = Category.all

  end

  def show
    @content_files = ContentFile.find(params[:id])
  end


end
