class SongsController < ApplicationController
  def update
    Song.find(params[:id]).move_to!(params[:position])
    head :ok
  end
end
