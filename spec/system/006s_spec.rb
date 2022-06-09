require 'rails_helper'

RSpec.describe '006s', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'Users will be redirected to "new" page if the system fails to parse uploaded palylist' do
    visit root_path
    click_link 'Upload playlist to start'
    attach_file 'upload_file', file_fixture('invalid_playlist.txt')
    click_button 'Upload'

    expect(page).to have_text('Upload your playlist')
    expect(page).to have_text('Playlist parse error. Please check what you have uploaded.')
  end
end
