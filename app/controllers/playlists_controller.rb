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
        @rec.songs
      end

    send_data(generate_json, filename: @rec.filename) if params[:download].present?
  end

  def new
    # Nothing to do
  end

  def create
    rec, songs = build_playlist
    if rec.save!
      session[:playlist_id] = rec.id.to_s

      songs.each do |song|
        rec.songs.create(song_name: song['songName'], original: song)
      end

      redirect_to playlist_path(rec)
    else
      render 'new'
    end
  end

  private

  def build_playlist
    json = JSON.parse(params[:upload_file].read)
    rec = Playlist.new

    field_list.each do |field, json_field|
      rec[field] = json.delete(json_field)
    end

    songs = json.delete('songs')

    rec.others = json
    rec.filename = params[:upload_file].original_filename

    [rec, songs]
  end

  def field_list
    # Playlist Model field name: json filed name
    {
      playlist_title: 'playlistTitle',
      playlist_author: 'playlistAuthor',
      playlist_description: 'playlistDescription',
      image: 'image'
    }
  end

  def generate_json
    playlist = {
      playlistTitle: @rec.playlist_title,
      playlistAuthor: @rec.playlist_author,
      playlistDescription: @rec.playlist_description,
      songs: @songs.pluck(:original),
      image: @rec.image
    }
    playlist.merge(@rec.others) if @rec.others.present?
    JSON.pretty_generate(playlist)
  end

  def session_invalid?
    if session.blank? || session[:playlist_id].blank? || (session[:playlist_id] != params[:id])
      true
    else
      false
    end
  end
end
