class PlaylistsController < ApplicationController
  def index
    # Clear existing records during development
    Playlist.destroy_all
  end

  def show
    # Only my playlist is available
    if session.blank? || session[:playlist_id].blank? || (session[:playlist_id] != params[:id])
      redirect_to playlists_path
    end

    @rec = Playlist.find(params[:id])
    redirect_to playlists_path if @rec.blank?
  end

  def new
    # Nothing to do
  end

  def create
    # !!Implement safety checks
    json = JSON.parse(params[:upload_file].read)

    rec = build_playlist(json: json)
    rec.filename = params[:upload_file].original_filename
    if rec.save!
      session[:playlist_id] = rec.id.to_s
      redirect_to playlist_path(rec)
    else
      render 'new'
    end
  end

  private

  def build_playlist(json: nil)
    rec = Playlist.new

    field_list.each do |field, json_field|
      rec[field] = json[json_field]
      json.delete(json_field)
    end

    json.delete('songs')
    rec.others = json

    rec
  end

  def field_list
    {
      playlist_title: 'playlistTitle',
      playlist_author: 'playlistAuthor',
      playlist_description: 'playlistDescription',
      image: 'image'
    }
  end
end
