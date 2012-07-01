class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_controller_and_action_names
  
  def download_file
    @content_file = ContentFile.find(params[:id])
    if params[:type] == "word"
      if @content_file.word_file.to_s.nil?
        flash[:notice] = "This file cannot be downloaded"
      else
        flash[:success] = "Thanks for downloading the file"
        send_file "public" + @content_file.word_file_url.to_s
        @download = Download.create(:user_id => current_user.id, :content_file_id => @content_file.id)
        @content_file.service_area_id = current_user.hospital.service_area_id
        @content_file.save
      end
    elsif params[:type] == "dreamweaver"
      if @content_file.dreamweaver_file.to_s.nil?
        flash[:notice] = "This file cannot be downloaded"
      else
        flash[:success] = "Thanks for downloading the file"
        send_file("public" + @content_file.dreamweaver_file_url.to_s, :disposition => 'attachment')
        @download = Download.create(:user_id => current_user.id, :content_file_id => @content_file.id)
        @content_file.service_area_id = current_user.hospital.service_area_id
        @content_file.save
      end
    else
      flash[:notice] = "There was a problem downloading the file"
      redirect_to content_files_url
    end
  end

  def set_controller_and_action_names
    @current_controller = controller_name
    @current_action     = action_name
  end

  def after_sign_in_path_for(user)
    if user.class.to_s == "AdminUser"
      admin_dashboard_url
    else
      content_files_url 
    end
  end

end
