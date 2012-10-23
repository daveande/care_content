class DownloadsController < ApplicationController  
  before_filter :authenticate_user!
  
  def create
    @content_file = ContentFile.find(params[:content_file_id])
    url = params[:type] +'_file_url'

    if params[:count] == 'true'
      @download = Download.new(:user_id => current_user.id, 
                              :content_file_id => @content_file.id, 
                              :service_area_id => current_user.hospital.service_area_id,
                              :purchase_id => current_user.current_purchase
                              )

      if @download.valid?
        flash[:notice] = "Your file has been downloaded"
        @download.save 
        redirect_to @content_file.send(url).to_s
      else
        messages = @download.errors.full_messages.join(" | ")
        flash[:notice] = messages
        redirect_to content_files_url
      end
    else
      redirect_to @content_file.send(url).to_s
    end
  end
    
end
