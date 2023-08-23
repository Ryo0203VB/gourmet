class User::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:dummy]
  before_action :ensure_guest_user, only: [:edit, :update]
  before_action :reject_customer, only: [:create]

  def dummy
    redirect_to new_user_registration_path
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.all.page(params[:page]).per(3)
    #チャット
			#Entry内のuser_idがcurrent_userと同じEntry
			@currentUserEntry = Entry.where(user_id: current_user.id)
			#Entry内のuser_idがMYPAGEのparams.idと同じEntry
		  @userEntry = Entry.where(user_id: @user.id)
		    	#@user.idとcurrent_user.idが同じでなければ
			    if @user.id == current_user.id
			    else
			      @currentUserEntry.each do |cu|
			        @userEntry.each do |u|
			          #もしcurrent_user側のルームidと＠user側のルームidが同じであれば存在するルームに飛ぶ
			          if cu.room_id == u.room_id then
			            @isRoom = true
			            @roomId = cu.room_id
			          end
			        end
			      end
			      #ルームが存在していなければルームとエントリーを作成する
			      if @isRoom
			      else
			        @room = Room.new
			        @entry = Entry.new
			      end
			    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "登録情報を更新しました"
      redirect_to user_path
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
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :phone_number, :image, :introduction, :is_deleted)
  end

 def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
 end


  def reject_end_user
      @end_user = EndUser.find_by(email: params[:end_user][:email])
      if @end_user
        if @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_deleted == true)
          flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
          redirect_to new_end_user_registration_path
        else
          flash[:notice] = "項目を入力してください"
        end
      else
        flash[:notice] = "該当するユーザーが見つかりません"
      end
  end

end

