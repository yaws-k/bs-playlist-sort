require 'rails_helper'

RSpec.describe '005s', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'Users can restore the order back to the original' do
    visit root_path
    click_link 'Upload playlist to start'
    attach_file 'upload_file', file_fixture('valid_playlist.json')
    click_button 'Upload'

    click_button 'Z -> A'
    expect(page.text).to match(/Astronomia.*\* Crow Solace \*/)

    click_button 'Reset'
    expect(page.text).to match(/\* Crow Solace \*.*Astronomia/)
  end
end
