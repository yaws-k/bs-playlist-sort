require 'rails_helper'

RSpec.describe '007s', type: :system do
  let(:playlist) { create(:playlist) }
  before do
    driven_by(:rack_test)
  end

  it "Users will be redirected to 'index' when attempting to access  other's playlist" do
    visit root_path
    click_link 'Upload playlist to start'
    attach_file 'upload_file', file_fixture('valid_playlist.json')
    click_button 'Upload'
    expect(page).to have_text('Reorder songs')

    visit "/playlists/#{playlist.id}/edit"
    expect(page).to have_text('Beat Saber playlist sorter')
  end
end
