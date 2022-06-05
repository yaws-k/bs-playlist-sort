require 'rails_helper'

RSpec.describe Playlist, type: :model do
  describe 'field checks' do
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
end
