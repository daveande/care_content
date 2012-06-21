class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def download_file
    @content_file = ContentFile.find(params[:id])
    if @content_file.word_file.to_s.nil?
      flash[:notice] = "This file cannot be downloaded"
      redirect_to content_files_url
    else
      flash[:success] = "Thanks for downloading the file"
      send_file "public" + @content_file.word_file_url.to_s
      @download = Download.create(:user_id => current_user.id, :content_file_id => @content_file.id)
    end
  end

end
