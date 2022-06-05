FactoryBot.define do
  factory :playlist do
    playlist_title { Faker::String.random }
    image { 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABASURBVDhPvcohDsAwAMSw/v/TG4jxaaQzjHL+8nxgjTZZo03WaJM12mSNNlmjTdZokzXaZI02WaNN1miT9bJzXhQtrmD22l8jAAAAAElFTkSuQmCC' }
    filename { "#{Faker::Alphanumeric.alphanumeric(number: 10)}.json" }

    trait :full_fields do
      playlist_author { Faker::String.random }
      playlist_description { Faker::String.random }
      others do
        { 'syncURL' => "https://bsaber.com/PlaylistAPI/#{Faker::Alphanumeric.alphanumeric(number: 10)}.json" }
      end
    end
  end
end
