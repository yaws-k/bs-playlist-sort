require 'rails_helper'

RSpec.describe '004s', type: :system do
  before do
    driven_by(:rack_test)
  end

  it "Users can access 'show' page if it is what they uploaded" do
    visit root_path
    click_link 'Upload playlist to start'
    attach_file 'upload_file', file_fixture('valid_playlist.json')
    click_button 'Upload'
    expect(page).to have_text('Reorder songs')

    click_link 'Go back to Top'
    expect(page).to have_text('Beat Saber playlist sorter')

    visit "/playlists/#{Playlist.last.id}/edit"
    expect(page).to have_text('Reorder songs')
  end
end
