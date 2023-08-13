class User::UsersController < ApplicationController



  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "登録情報を更新しました"
      redirect_to users_path
    else
      render "edit"
    end
  end

  # 顧客の退会確認画面
  def confirm_withdraw
  end

  # 顧客の退会処理(ステータスの更新)
  def withdraw
    @user = current_user
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :phone_number, :image, :is_deleted)
  end



end

