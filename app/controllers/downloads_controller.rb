class DownloadsController < ApplicationController  

  def create
    @content_file = ContentFile.find(params[:content_file_id])
    if params[:type] == "word"
      if @content_file.word_file.to_s.nil?
        flash[:notice] = "This file cannot be downloaded"
      else
        flash[:success] = "Thanks for downloading the file"
        @download = Download.create(:user_id => current_user.id, :content_file_id => @content_file.id, :service_area_id => current_user.hospital.service_area_id)
        redirect_to @content_file.word_file_url.to_s
      end
    elsif params[:type] == "dreamweaver"
      if @content_file.dreamweaver_file.to_s.nil?
        flash[:notice] = "This file cannot be downloaded"
      else
        flash[:success] = "Thanks for downloading the file"
        @download = Download.create(:user_id => current_user.id, :content_file_id => @content_file.id, :service_area_id => current_user.hospital.service_area_id)
        redirect_to @content_file.dreamweaver_file_url.to_s
      end
    else
      flash[:notice] = "There was a problem downloading the file"
      redirect_to content_files_url
    end
  end
end
