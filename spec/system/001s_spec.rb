require 'rails_helper'

RSpec.describe '001s', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'Users can upload a playlist to see all songs' do
    visit root_path
    expect(page).to have_text('Beat Saber playlist sorter')

    click_link 'Upload playlist to start'
    expect(page).to have_text('Upload your playlist')

    attach_file 'upload_file', file_fixture('valid_playlist.json')
    click_button 'Upload'
    expect(page).to have_text('Reorder songs')
    expect(page).to have_text('Sample playlist')
    expect(page).to have_text('Author Name')
    expect(page).to have_text('Playlist descriotion')

    expect(page).to have_text('2 Songs')
    expect(page.text).to match(/\* Crow Solace \*.*Astronomia/)
  end
end
