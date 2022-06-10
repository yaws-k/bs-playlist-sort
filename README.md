# Beat Saber Playlist Sort

You can sort your songs in your playlists. BetterSongList MOD will enable you to sort songs ingame, but you don't have to sort them everytime you open a playlist if it is already sorted.
Visit https://bsps.yaw.jp/ to use this.

# System information

This is a practice projects to use Rails 7.

## Versions

* Ruby version: 3.1.x
* Rails version: 7.0.x

## Requirements

* MongoDB (>5.0)
* Node.js (>16.15.x)

Unlike usual Rails system, this system uses MongoDB (through Mongoid) only. You don't need MariaDB(MySQL) or PostgreSQL.

credentials.yml should have MongoDB credentials.

```
mongodb:
  development:
    user: <username>
    password: <password>
  test:
    user: <username>
    password: <password>
  production:
    user: <username>
    password: <password>
```

As is often the case with modern Rails, puma should start through systemd and a reverse proxy should be set up.
