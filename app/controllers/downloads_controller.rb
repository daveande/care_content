class DownloadsController < ApplicationController  

  def create
    @content_file = ContentFile.find(params[:content_file_id])
    if @content_file.can_download?(params[:type])
      url = params[:type] +'_file_url'
      flash[:notice] = "Your file has been downloaded"
      Download.create(:user_id => current_user.id, 
                      :content_file_id => @content_file.id, 
                      :service_area_id => current_user.hospital.service_area_id
                     ) unless params[:count] == 'false' 
      redirect_to @content_file.send(url).to_s
    else
      flash[:notice] = "This file cannot be downloaded or there was a problem downloading the file"
      redirect_to content_files_url
    end
  end
end
