class Song
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :playlist

  # validations
  validates \
    :song_name,
    :original,
    :original_pos,
    presence: true

  # fields
  field :song_name, type: String
  index({ song_name: 1 }, { sparse: false })

  # Original data
  field :original, type: Hash
  field :original_pos, type: Integer
  index({ original_pos: 1 }, { sparse: false })

  # Class methods
  class << self
    def import_songs(songs: [], playlist_id: nil)
      return false if songs.blank? || playlist_id.blank?

      songs.each_with_index do |song, i|
        Song.create(
          playlist_id:,
          song_name: song['songName'],
          original: song,
          original_pos: i + 1
        )
      end

      true
    end
  end
end
