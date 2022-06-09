class PlaylistsController < ApplicationController
  def index
    # Nothing to do
  end

  def show
    # Only my playlist is available
    if session_invalid?
      redirect_to playlists_path
      return
    end

    @rec = Playlist.find(params[:id])
    if @rec.blank?
      redirect_to playlists_path
      return
    end

    @songs = @rec.songs.order(pos: :asc)

    send_data(@rec.export_json(songs: @songs), filename: @rec.filename)
  end

  def new
    # Nothing to do
  end

  def create
    if params[:upload_file].blank?
      redirect_to new_playlist_path
      return
    end

    rec_id = Playlist.import_json(json: params[:upload_file])
    if rec_id
      session[:playlist_id] = rec_id.to_s
      redirect_to edit_playlist_path(rec_id)
    else
      render 'new'
    end
  end

  def edit
    # Only my playlist is available
    if session_invalid?
      redirect_to playlists_path
      return
    end

    @playlist = Playlist.find(params[:id])
    if @playlist.blank?
      redirect_to playlists_path
      return
    end

    @songs = @playlist.songs.order(pos: :asc)
  end

  def update
    playlist = Playlist.find(params[:id])
    playlist.reorder_songs(type: params[:type])

    redirect_to edit_playlist_path(playlist)
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
