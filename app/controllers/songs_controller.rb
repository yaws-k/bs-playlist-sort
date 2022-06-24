class SongsController < ApplicationController
  def update
    rec = Song.find(params[:id])
    Song.with_session do
      rec.move_to! params[:position]
    end
    head :ok
  end
end
