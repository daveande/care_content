class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_controller_and_action_names
  
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
