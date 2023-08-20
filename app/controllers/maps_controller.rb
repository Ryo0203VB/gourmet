class MapsController < ApplicationController

  def index
    @address = params[:address] ? params[:address] : nil
  end

end
