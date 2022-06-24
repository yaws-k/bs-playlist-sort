FactoryBot.define do
  factory :song do
    playlist

    song_name { Faker::String.random }
    original do
      {
        songName: Faker::String.random,
        hash: Faker::Number.hexadecimal(digits: 40)
      }
    end
    sequence(:original_position, 1)
    sequence(:position, 1)
  end
end
