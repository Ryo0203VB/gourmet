class User::PostsController < ApplicationController

  before_action :set_select_genres

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
    @genres = Genre.all
  end

   def index
   @posts = Post.left_joins(:favorites).group(:id).order('count(post_id) desc').page(params[:page]).per(12)
   end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @user = User.find(current_user.id)
    if @post.save
      redirect_to post_path(@post.id), notice: "投稿できました"
    else
      @posts = Post.all
      redirect_to new_post_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path, notice: "編集できました"
    else
      redirect_to edit_post_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:name, :introduction, :address, :image,  :star, :genre_id, :user_id)
  end

 def set_select_genres
     @genres = Genre.all.map {|genre| [genre.name, genre.id] }.unshift(["--選択してください--", nil])
 end

  def is_matching_login_user
      @post  = Post.find(params[:id])
       unless @post.user.id == current_user.id
         redirect_to posts_path
       end
  end

end