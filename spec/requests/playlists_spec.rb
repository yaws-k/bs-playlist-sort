require 'rails_helper'

RSpec.describe 'Playlists', type: :request do
  describe '#index' do
    it 'returns http success' do
      get '/playlists'
      expect(response).to have_http_status(:success)
    end

    context 'with root address' do
      it 'returns http success' do
        get '/'
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#show' do
    let(:playlist) { create(:playlist) }

    context 'without valid session' do
      it 'returns http redirect' do
        get "/playlists/#{playlist.id}"
        expect(response).to redirect_to playlists_path
      end
    end
  end

  describe '#new' do
    it 'returns http success' do
      get '/playlists/new' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#create' do
    it 'returns http redirect' do
      post '/playlists', params: {
        upload_file: fixture_file_upload('valid_playlist.json')
      }
      expect(response).to redirect_to edit_playlist_path(Playlist.order(created_at: :desc).first)
    end
  end

  describe '#edit' do
    let(:playlist) { create(:playlist) }

    context 'without valid session' do
      it 'returns http redirect' do
        get "/playlists/#{playlist.id}/edit"
        expect(response).to redirect_to playlists_path
      end
    end
  end

  describe '#update' do
    let(:song) { create(:song) }
    it 'returns http redirect' do
      playlist = song.playlist
      patch "/playlists/#{playlist.id}", params: {
        type: 'desc'
      }
      expect(response).to redirect_to edit_playlist_path(playlist)
    end
  end
end
