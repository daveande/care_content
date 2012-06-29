class ContentFilesController < ApplicationController
  before_filter :authenticate_user!

  def index
    content_files_filtered = ContentFile.where('service_area_id is not ?', current_user.hospital.service_area_id.to_s) 
    if params[:category]
      @category = params[:category]
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
