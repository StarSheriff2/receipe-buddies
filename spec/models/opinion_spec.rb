require 'rails_helper'

RSpec.describe Opinion, type: :model do
  before do
    User.create(username: 'Master_Chef', fullname: 'Gordon Ramsay')
  end

  let(:user1) { User.find_by_username('Master_Chef') }

  # Model Tests
  context 'with correct params' do
    before do
      @opinion = Opinion.create(text: 'I highly recommend you try this receipe at home', author_id: user1.id)
    end

    it 'creates an opinion' do
      expect(@opinion).to be_valid
    end

    it 'reads an opinion' do
      author_id = user1.id
      expect(Opinion.find_by_author_id(author_id)).to eq(@opinion)
    end
  end

  context 'with incorrect params' do
    before do
      @opinion = Opinion.new(text: 'I highly recommend you try this receipe at home')
    end

    it 'cannot create an opinion' do
      expect(@opinion).not_to be_valid
    end

    it 'cannot read an opinion' do
      text = 'I highly recommend you try this receipe at home'
      expect(@opinion_text).not_to eq(text)
    end
  end

  # Association Tests
  it { should belong_to(:author).class_name('User') }

  # Validation Tests
  it 'is not valid without valid attributes' do
    expect(Opinion.new).to_not be_valid
  end

  context 'it is valid with valid attributes' do
    describe '#text' do
      it { should validate_presence_of(:text) }
      it do
        should validate_length_of(:text).is_at_most(1000)
          .with_message('1000 characters in opinion is the maximum allowed.')
      end
    end
  end
end
