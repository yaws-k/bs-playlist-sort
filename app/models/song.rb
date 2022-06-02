class Song
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :playlist

  # validations
  validates \
    :song_name,
    :original,
    :original_order,
    presence: true

  # fields
  field :song_name, type: String
  index({ song_name: 1 }, { sparse: false })

  # Original data
  field :original, type: Hash
  field :original_order, type: Integer
  index({ original_order: 1 }, { sparse: false })
end
