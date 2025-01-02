# Beat Saber Playlist Sort

![GitHub Release Date](https://img.shields.io/github/release-date/yaws-k/bs-playlist-sort)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/yaws-k/bs-playlist-sort)
[![Run RSpec](https://github.com/yaws-k/bs-playlist-sort/actions/workflows/rspec.yml/badge.svg)](https://github.com/yaws-k/bs-playlist-sort/actions/workflows/rspec.yml)
![GitHub](https://img.shields.io/github/license/yaws-k/bs-playlist-sort)

You can sort your songs in your playlists, and download updated ones.

## Requirements

* Ruby 3.2.x
* Rails 7.0.x
* MongoDB (>5.0)
* Node.js (>18.x)

Unlike usual Rails system, this system uses MongoDB (through Mongoid) only. You don't need MariaDB(MySQL) or PostgreSQL.

credentials.yml should have MongoDB credentials.

```yaml
mongodb:
  development:
    dbname: <development database name>
    user: <username>
    password: <password>
  test:
    dbname: <test database name>
    user: <username>
    password: <password>
  production:
    dbname: <production database name>
    user: <username>
    password: <password>
```

As is often the case with modern Rails, puma should start through systemd and a reverse proxy should be set up.
