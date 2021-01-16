# frozen_string_literal: true

# Explanation of Person class
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  protected

  def after_sign_in_path_for(resource)
    p "====-----#{resource.inspect}"
    if resource.has_role? :admin
      admin_users_path
    elsif resource.has_role? :team_leader
      team_leader_users_path
    elsif resource.has_role? :devloper
      devloper_users_path
    elsif resource.has_role? :trainee
      trainee_users_path
    else
      user_page_path(resource)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone_no state_id city_id company_id])
  end
end
