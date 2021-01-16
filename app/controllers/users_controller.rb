# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user

  def page; end

  def index
    @users = User.admin.joins(:state, :city, :company).select('users.*,states.name as state_name', 'users.*,cities.name as city_name', 'users.*,companies.name as company_name').distinct
  end

  def edit; end

  def show
    @user = User.find(params[:id])
  end

  def authenticate_user
    redirect_to root_path unless current_user.has_role? :admin
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
