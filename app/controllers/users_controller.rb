class UsersController < ApplicationController

    def page
    end
    
    def index
        @users = User.all
    end

    def edit
        p "uigtuyfrtuyfuyftuyftuyhftuyftugg-=---------------"
    end

    def show
        @user = User.find(params[:id])
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
