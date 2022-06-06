class PlaylistsController < ApplicationController
  def index
    # Clear existing records during development
    Playlist.destroy_all
  end

  def show
    # Only my playlist is available
    redirect_to playlists_path if session_invalid?

    @rec = Playlist.find(params[:id])
    redirect_to playlists_path if @rec.blank?

    @songs =
      case params[:sort]
      when 'asc'
        @rec.songs.order(song_name: :asc)
      when 'desc'
        @rec.songs.order(song_name: :desc)
      else
        @rec.songs.order(original_order: :asc)
      end

    send_data(@rec.export_json(songs: @songs), filename: @rec.filename) if params[:download].present?
  end

  def new
    # Nothing to do
  end

  def create
    if params[:upload_file].blank?
      redirect_to new_playlist_path
      return
    end

    rec, songs = Playlist.import_json(json: params[:upload_file])
    if rec.save
      Song.import_songs(songs:, playlist_id: rec.id)
      session[:playlist_id] = rec.id.to_s
      redirect_to playlist_path(rec)
    else
      render 'new'
    end
  end

  private

  def session_invalid?
    if session.blank? || session[:playlist_id].blank? || (session[:playlist_id] != params[:id])
      true
    else
      false
    end
  end
end
