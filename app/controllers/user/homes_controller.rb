class User::HomesController < ApplicationController

  def top
    # @posts = Post.all
    # # 新着商品（４つ）
    # @posts_latest4 = @posts.first(4)
    # @genres = Genre.all
  end

private

  def set_item
    # PATHパラメータでitemを取得
    # @Post = Post.find_by(params[:post_id])
  end

end