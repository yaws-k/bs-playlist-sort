require 'rails_helper'

RSpec.describe 'Playlists', type: :request do
  describe 'GET /index' do
    it 'returns playlists/index as root' do
      get '/'
      expect(response).to have_http_status(:success)
    end

    it 'returns index' do
      get '/playlists/'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    # TBD
  end

  describe 'GET /new' do
    # TBD
  end

  describe 'POST /create' do
    # TBD
  end
end
