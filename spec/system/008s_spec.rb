require 'rails_helper'

RSpec.describe '008s', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'Users can change song positions with Drag & Drop' do
    visit root_path
    click_link 'Upload playlist to start'
    attach_file 'upload_file', file_fixture('valid_playlist.json')
    click_button 'Upload'
    expect(page).to have_text('Reorder songs')
    expect(page.text).to match(/\* Crow Solace \*.*Astronomia/)

    song = Song.find_by(song_name: '* Crow Solace *')
    patch "/songs/#{song.id}", params: { position: '2' }

    visit edit_playlist_path(Playlist.first)
    expect(page.text).to match(/Astronomia.*\* Crow Solace \*/)
  end
end
