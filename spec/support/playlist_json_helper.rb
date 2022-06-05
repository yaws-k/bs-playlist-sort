module PlaylistJsonHelpers
  def valid_playlist_json
    {
      "playlistTitle": Faker::String.random,
      "playlistAuthor": "",
      "playlistDescription": "",
      "songs": [
        {
          "songName": Faker::String.random,
          "levelAuthorName": Faker::Alphanumeric.alphanumeric(number: 10),
          "hash": "321AE03C2A7CC981BE02206ACFEB855426E20973",
          "levelid": "custom_level_321AE03C2A7CC981BE02206ACFEB855426E20973",
          "difficulties": []
        },
        {
          "songName": Faker::String.random,
          "levelAuthorName": Faker::Alphanumeric.alphanumeric(number: 10),
          "hash": "2E6CB362F31D00EE9F2B9C8640CFD94BBFB8377F",
          "levelid": "custom_level_2E6CB362F31D00EE9F2B9C8640CFD94BBFB8377F",
          "difficulties": []
        }
      ],
      "image": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABASURBVDhPvcohDsAwAMSw/v/TG4jxaaQzjHL+8nxgjTZZo03WaJM12mSNNlmjTdZokzXaZI02WaNN1miT9bJzXhQtrmD22l8jAAAAAElFTkSuQmCC"
    }
  end
end
