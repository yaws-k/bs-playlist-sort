require 'rails_helper'

RSpec.describe 'Songs', type: :request do
  describe '#update' do
    it 'returns http ok' do
      song1 = create(:song, position: 1)
      create(:song, position: 2)

      patch "/songs/#{song1.id}", params: {
        position: '2'
      }
      expect(response).to have_http_status(:success)
    end
  end
end
