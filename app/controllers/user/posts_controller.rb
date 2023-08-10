class User::PostsController < ApplicationController

  def new
    @posts = Post.new
  end


  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def index
    @posts = Post.all
    @post = Post.new
    @Post = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @user = User.find(current_user.id)
    if @post.save
      redirect_to post_path(@post.id), notice: "You have created book successfully."
    else
      @posts = Post.all
      render :index
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    # redirect_to books_path
  end

  private

  def post_params
    params.require(:post).permit(:name, :introduction, :user_id)
  end

 def set_select_genres
    @genres = Genre.all.map {|genre| [genre.name, genre.id] }.unshift(["--選択してください--", nil])
 end

  # def is_matching_login_user
  #     book = Book.find(params[:id])
  #     unless book.user.id == current_user.id
  #       redirect_to books_path
  #     end
  # end


end
