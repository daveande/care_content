class ContentFilesController < ApplicationController
  def index
    if params[:category]
      @content_files = ContentFile.joins(:categories).where(:categories => {:id => params[:category]})
    else
      @content_files = ContentFile.all
    end
    @categories = Category.all
  end

  def show
    @content_files = ContentFile.find(params[:id])
  end


end
