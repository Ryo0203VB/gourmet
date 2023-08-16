class ApplicationController < ActionController::Base
 before_action :search

 protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def search
    @q = User.ransack(params[:q])
    if params[:q].present?
     @search_word = params[:q][:last_name_or_first_name_cont]
    else
     @search_word = ""
    end
     @user = @q.result
     @result = params[:q]&.values&.reject(&:blank?)

     @genre = Genre.where(name: @search_word)
     @posts = Post.where(genre_id: @genre.ids)
  end

  protected

  def configure_permitted_parameters
    added_attrs = [ :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :phone_number, ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

end
