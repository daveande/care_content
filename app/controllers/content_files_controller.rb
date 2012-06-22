class ContentFilesController < ApplicationController
  def index
    @content_files = ContentFile.all
    @categories = Category.all
  end

  def show
    @content_files = ContentFile.find(params[:id])
  end


end
