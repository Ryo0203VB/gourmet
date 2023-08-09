class Admin::UsersController < ApplicationController


  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
   @users = User.find(params[:id])
  end

  def edit
    @users = User.find(params[:id])
  end

  def update
   @users = User.find(params[:id])
   if @users.update(user_params)
     flash[:notice] = "更新情報を更新しました"
     redirect_to admin_users_path
   else
     render :edit
   end
  end

  private
    def user_params
      params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :phone_number, :is_deleted)
    end

end
