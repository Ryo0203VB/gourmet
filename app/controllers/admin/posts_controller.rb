class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.find(params[:user_id])
    @posts = @users.posts
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(12)
  end

  def show
    @post = Post.find(params[:id])
    @user =  @post.user
  end

def destroy
  @post = Post.find(params[:id])
  user_id = @post.user.id

  @post.destroy
  redirect_to admin_user_posts_path(user_id), notice: "削除しました"
end

end
