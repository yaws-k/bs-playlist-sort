require 'rails_helper'

RSpec.describe '003s', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'Users can download sorted playlist' do
    visit root_path
    click_link 'Upload playlist to start'
    attach_file 'upload_file', file_fixture('valid_playlist.json')
    click_button 'Upload'

    click_button 'Z -> A'
    click_link 'Download current list'
    expect(page.text).to match(/Astronomia.*\* Crow Solace \*/)
  end
end
