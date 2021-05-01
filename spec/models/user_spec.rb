require 'rails_helper'

RSpec.describe User, type: :model do
  # Model Tests
  context 'with correct params' do
    before do
      @user = User.create(username: 'Peter_Parker', fullname: 'Peter Parker')
    end

    it 'creates a user' do
      expect(@user).to be_valid
    end

    it 'reads a user' do
      expect(User.find_by(username: 'Peter_Parker')).to eq(@user)
    end
  end

  context 'with incorrect params' do
    before do
      @user = User.create(username: 'Peter Parker', fullname: 'Peter Parker')
    end

    it 'cannot create a user' do
      expect(@user).not_to be_valid
    end

    it 'cannot read a user' do
      expect(User.find_by(username: 'Peter Parker')).not_to eq(@user)
    end
  end

  # Association Tests
  it { should have_many(:opinions) }

  context 'user as a follower' do
    before do
      User.create(username: 'Peter_Parker', fullname: 'Peter Parker')
      User.create(username: 'Jane_Watson', fullname: 'Jane Watson')
    end

    let(:follower) { User.find_by_username('Peter_Parker') }
    let(:followed) { User.find_by_username('Jane_Watson') }
    let(:new_following) { follower.followings.build(followed_id: followed.id) }

    it { should have_many(:followings) }

    it 'can follow another user' do
      followed_user = User.find(new_following.followed_id)
      expect(followed_user.username).to eq('Jane_Watson')
      expect(followed_user.username).to_not eq('Peter_Parker')
    end
  end

  context 'user as a followed user' do
    before do
      User.create(username: 'Peter_Parker', fullname: 'Peter Parker')
      User.create(username: 'Jane_Watson', fullname: 'Jane Watson')
    end

    let(:follower) { User.find_by_username('Peter_Parker') }
    let(:followed) { User.find_by_username('Jane_Watson') }
    let(:new_following) { follower.followings.build(followed_id: followed.id) }

    it { should have_many(:inverse_followings) }
    it { should have_many(:followers) }

    it 'can see the name of a follower' do
      follower_user = User.find(new_following.follower_id)
      expect(follower_user.username).to eq('Peter_Parker')
      expect(follower_user.username).to_not eq('Jane_Watson')
    end
  end

  # Validation Tests
  it 'is not valid without valid attributes' do
    expect(User.new).to_not be_valid
  end

  context 'it is valid with valid attributes' do
    describe '#username' do
      it { should validate_presence_of(:username) }
      it { should_not allow_value('Peter Parker').for(:username) }
      it { should validate_length_of(:username) }
      it { should validate_presence_of(:fullname) }
      it { should validate_length_of(:fullname) }
    end

    describe '#fullname' do
      it { should validate_presence_of(:fullname) }
      it { should validate_length_of(:fullname) }
    end
  end
end
