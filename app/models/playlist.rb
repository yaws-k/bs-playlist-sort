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
end
