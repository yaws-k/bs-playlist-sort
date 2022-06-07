require 'rails_helper'

RSpec.describe Playlist, type: :model do
  describe 'field' do
    let(:rec) { build(:playlist) }

    it 'is valid with required fields' do
      expect(rec).to be_valid
    end

    it 'is invalid without required fields' do
      rec.playlist_title = ''
      rec.image = ''
      rec.filename = ''

      expect(rec).to_not be_valid
      expect(rec.errors[:playlist_title]).to include("can't be blank")
      expect(rec.errors[:image]).to include("can't be blank")
      expect(rec.errors[:filename]).to include("can't be blank")
    end

    it 'is valid with full fields' do
      expect(build(:playlist, :full_fields)).to be_valid
    end
  end

  describe 'method' do
    describe 'import_json' do
      let(:json) { fixture_file_upload('valid_playlist.json') }

      it 'saves playlist record' do
        rec_id = Playlist.import_json(json:)

        rec = Playlist.find(rec_id)
        data = JSON.parse(file_fixture('valid_playlist.json').read)
        expect(rec).to be_valid
        expect(rec.playlist_title).to eq(data['playlistTitle'])
        expect(rec.playlist_author).to eq(data['playlistAuthor'])
        expect(rec.playlist_description).to eq(data['playlistDescription'])
        expect(rec.image).to eq(data['image'])
        expect(rec.others).to eq({ 'syncURL' => data['syncURL'] })
        expect(rec.filename).to eq(json.original_filename)
      end
    end

    describe 'export_json' do
      it 'generates json' do
        rec_id = Playlist.import_json(json: fixture_file_upload('valid_playlist.json'))
        rec = Playlist.find(rec_id)
        songs = rec.songs.order(original_pos: :desc)
        expect(rec.export_json(songs:)).to eq(file_fixture('song_desc.json').read)
      end
    end
  end
end
