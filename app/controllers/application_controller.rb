class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def download_file
    @content_file = ContentFile.find(params[:id])
    send_file "public" + @content_file.word_file_url.to_s
  end

end
