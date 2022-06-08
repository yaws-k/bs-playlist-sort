require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'field' do
    let(:rec) { build(:song) }

    it 'is valid with required fields' do
      expect(rec).to be_valid
    end

    it 'is invalid without required fields' do
      rec.song_name = ''
      rec.original = {}
      rec.original_pos = nil
      rec.pos = nil

      expect(rec).to_not be_valid
      expect(rec.errors[:song_name]).to include("can't be blank")
      expect(rec.errors[:original]).to include("can't be blank")
      expect(rec.errors[:original_pos]).to include("can't be blank")
      expect(rec.errors[:pos]).to include("can't be blank")
    end

    it 'is valid with full fields' do
      # All fields are required
    end

    it 'has default values' do
      rec = Song.new

      expect(rec.song_name).to eq('')
      expect(rec.original).to eq({})
      expect(rec.original_pos).to eq(0)
      expect(rec.pos).to eq(0)
    end
  end

  describe 'method' do
    describe 'import_songs' do
      let(:playlist) { create(:playlist) }
      let(:songs) { (JSON.parse(file_fixture('valid_playlist.json').read)['songs']) }

      it 'saves song records' do
        expect { Song.import_songs(songs:, playlist_id: playlist.id) }.to change { Song.count }.by(2)
      end

      it 'saves song fields' do
        Song.import_songs(songs:, playlist_id: playlist.id)

        rec = playlist.songs.order(original_pos: :asc).first
        data = songs[0]
        expect(rec.song_name).to eq(data['songName'])
        expect(rec.original).to eq(data)
        expect(rec.original_pos).to eq(1)
        expect(rec.pos).to eq(1)

        rec = playlist.songs.order(original_pos: :asc).last
        data = songs[1]
        expect(rec.song_name).to eq(data['songName'])
        expect(rec.original).to eq(data)
        expect(rec.original_pos).to eq(2)
        expect(rec.pos).to eq(2)
      end
    end
  end
end
