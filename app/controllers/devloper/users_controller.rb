# frozen_string_literal: true

# Explanation of Person class

module Devloper
  class UsersController < ApplicationController
    before_action :authenticate_user
    before_action :set_user, only: %i[show edit update destroy]
    load_and_authorize_resource

    # GET /users
    # GET /users.json
    def index
      @users = User.trainee.joins(:state, :city, :company).select('users.*,states.name as state_name', 'users.*,cities.name as city_name', 'users.*,companies.name as company_name').distinct
    end

    # GET /users/1
    # GET /users/1.json
    def show; end

    # GET /users/new
    def new
      @user = User.new
    end

    # GET /users/1/edit
    def edit; end

    # POST /users
    # POST /users.json
    def create
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def getcity
      @state = State.find(params[:state_id])
      @cities = @state.cities
      # render json: { cities: @cities }
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def authenticate_user
      redirect_to root_path unless current_user.has_role? :devloper
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :phone_no, :city_id, :state_id, :company_id)
    end
  end
end
