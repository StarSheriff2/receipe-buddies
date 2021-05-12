require 'rails_helper'

RSpec.describe Following, type: :model do
  before do
    User.create(username: 'Master_Chef', fullname: 'Gordon Ramsay')
    User.create(username: 'Jolly-Cooker', fullname: 'Susy Clark')
  end

  let(:user1) { User.find_by_username('Master_Chef') }
  let(:user2) { User.find_by_username('Jolly-Cooker') }

  # Model Tests
  context 'with correct params' do
    before do
      @following = Following.create!(follower_id: user1.id, followed_id: user2.id)
    end

    it 'creates a follow relationship' do
      expect(@following).to be_valid
    end

    it 'reads an opinion' do
      follower_id = user1.id
      expect(Following.find_by_follower_id(follower_id)).to eq(@following)
    end

    it 'doesn\'t allow a user to follow same user twice' do
      @following = user1.followings.build(followed_id: user2.id)
      error = ActiveRecord::RecordNotUnique
      expect { @following.save! }.to raise_error(error)
    end
  end

  context 'with incorrect params' do
    before do
      @following = Following.create(follower_id: user1.id)
    end

    it 'cannot create a Following record' do
      expect(@following).not_to be_valid
    end

    it 'cannot read a Following record' do
      follower_id = user1.id
      expect(Following.find_by_follower_id(follower_id)).to be_nil
    end
  end

  # Association Tests
  it { should belong_to(:follower).class_name('User') }
  it { should belong_to(:followed).class_name('User') }
end
