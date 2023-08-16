class User::ChatsController < ApplicationController
  before_action :authenticate_user!, :only => [:create]

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:chat][:room_id]).present?
      @chat = Chat.new(params.require(:chat).permit(:message, :user_id, :room_id).merge(:user_id => current_user.id))
      @chat.save!
      redirect_to "/rooms/#{@chat.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end


end
