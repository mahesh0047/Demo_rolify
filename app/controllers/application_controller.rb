# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    if resource.has_role? :admin
      admin_users_path
    elsif resource.has_role? :team_leader
      team_leader_users_path
    elsif resource.has_role? :devloper
      devloper_users_path
    elsif resource.has_role? :trainee
      trainee_users_path
    else
      user_page_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone_no state_id city_id company_id])
  end
end
