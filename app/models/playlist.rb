class Playlist
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :songs, dependent: :destroy

  # validations
  validates \
    :playlist_title,
    :image,
    :filename,
    presence: true

  # playlist contents
  field :playlist_title, type: String
  field :playlist_author, type: String
  field :playlist_description, type: String
  field :image, type: String
  field :others, type: Hash

  # playlist data
  field :filename, type: String

  # Class methods
  class << self
    def import_json(json: nil)
      filename = json.original_filename
      data = JSON.parse(json.read)
      songs = data.delete('songs')

      rec = Playlist.new
      field_list.each do |db_field, data_field|
        rec[db_field] = data.delete(data_field)
      end
      rec.others = data
      rec.filename = filename

      # Save playlist record and its songs
      return false unless rec.save
      return false unless Song.import_songs(songs:, playlist_id: rec.id)

      rec.id
    end

    private

    def field_list
      # Playlist Model field name: json filed name
      {
        playlist_title: 'playlistTitle',
        playlist_author: 'playlistAuthor',
        playlist_description: 'playlistDescription',
        image: 'image'
      }
    end
  end

  # Instance methods
  def export_json(songs: [])
    playlist = {
      playlistTitle: playlist_title,
      playlistAuthor: playlist_author,
      playlistDescription: playlist_description,
      songs: songs.pluck(:original),
      image:
    }
    playlist.merge!(others) if others.present?
    JSON.pretty_generate(playlist)
  end
end
