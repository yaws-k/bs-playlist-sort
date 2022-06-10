namespace :playlist_cleanup do
  desc 'Delete old playlists and songs'

  task do: :environment do
    logger = Logger.new($stdout)

    playlists = Playlist.where(:created_at.lt => Time.current.ago(2.days))
    logger.info { "#{playlists.size} playlists deleted" }
    playlists.destroy_all
  end
end
