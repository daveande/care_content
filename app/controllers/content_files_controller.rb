class ContentFilesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @your_downloads = ContentFile.joins(:downloads).where(:downloads => {:user_id => current_user.id})

    if Rails.env.production?
      content_files_filtered = ContentFile.where('service_area_id is ? OR service_area_id <> ?', nil, current_user.hospital.service_area_id)
    else
      all = ContentFile.all
      content_files_filtered = ContentFile.joins(:downloads).where(:downloads => {:service_area_id => current_user.hospital.service_area_id})
      content_files_filtered_by_service_area = all - content_files_filtered
    end

    if params[:category]
      @category = params[:category]
      content_files_filtered_by_category = ContentFile.joins(:categories).where(:categories => {:id => params[:category]})
      @content_files = content_files_filtered_by_category - content_files_filtered 
    else
      @category = 'all'
      @content_files = content_files_filtered_by_service_area 
    end
    @categories = Category.all

  end

  def show
    @content_files = ContentFile.find(params[:id])
  end


end
