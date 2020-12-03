# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]
    load_and_authorize_resource

    # GET /users
    # GET /users.json
    def index
      @users = User.admin
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
      p "==========#{params.inspect}"
      password = params[:user][:password] = 123_456
      role = params[:user][:roles]
      language_ids = params[:user][:languages]
      # p"::::::::::#{language.inspect}"
      @user = User.new(user_params)
      @user.add_role role
      @user.language_ids = language_ids
      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_users_url(@user), notice: 'User was successfully created.' }
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
      language_ids = params[:user][:languages]
      @user.language_ids = language_ids
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_user_path(@user), notice: 'User was successfully updated.' }
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
        format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def get_city
      @state = State.find(params[:state_id])
      @cities = @state.cities
      # render json: { cities: @cities }
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :phone_no, :password, :city_id, :state_id, :company_id)
    end
  end
end
