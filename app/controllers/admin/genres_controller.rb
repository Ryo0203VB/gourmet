class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  # before_action :find_genre, only: [:edit, :update]

  def index
    @genre = Genre.new
    @genres = Genre.all.page(params[:page]).per(5)
  end

  def create
    @genre = Genre.new(genre_params)
    @genres = Genre.all
    @genre.save
    redirect_to admin_genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path
  end

  def destroy
   @genres = Genre.find(params[:id])
   @genres.destroy
   redirect_to admin_genres_path, success: '削除しました。'
  end

private

def genre_params
     params.require(:genre).permit(:name)
end

end
