require 'rails_helper'

RSpec.describe Vote, type: :model do
  before do
    User.create(username: 'Master_Chef', fullname: 'Gordon Ramsay')
    User.create(username: 'Jolly-Cooker', fullname: 'Susy Clark')
  end

  let(:user1) { User.find_by_username('Master_Chef') }
  let(:user2) { User.find_by_username('Jolly-Cooker') }
  let(:opinion1) { Opinion.create(text: 'I highly recommend you try this receipe at home', author_id: user1.id) }
  let(:opinion2) { Opinion.create(text: 'We tried this recipe last night, and it was delicious', author_id: user2.id) }

  # Model Tests
  context 'with correct params' do
    before do
      @vote = Vote.create(opinion_id: opinion1.id, user_id: user2.id)
      @vote_own = Vote.create(opinion_id: opinion2.id, user_id: user2.id)
    end

    it 'creates a vote' do
      expect(@vote).to be_valid
    end

    it 'reads a vote' do
      user_id = user2.id
      expect(Vote.find_by_user_id(user_id)).to eq(@vote)
    end

    it 'allows user to vote for his own opinion' do
      expect(@vote_own).to be_valid
    end

    it 'allows user to vote for more than one opinion' do
      votes = Vote.where(user_id: user2).count
      expect(votes).to eq(2)
    end

    it 'doesn\'t allow a user to vote twice for same opinion' do
      vote_twice = user2.votes.build(opinion_id: opinion1.id)
      error = ActiveRecord::RecordNotUnique
      expect { vote_twice.save! }.to raise_error(error)
    end
  end

  context 'with incorrect params' do
    before do
      @vote = Vote.create(opinion_id: opinion1.id, user_id: 20)
    end

    it 'cannot create a Vote record' do
      expect(@vote).not_to be_valid
    end

    it 'cannot read a Vote record' do
      user_id = 20
      expect(Vote.find_by_user_id(user_id)).to be_nil
    end
  end

  # Association Tests
  it { should belong_to(:opinion) }
  it { should belong_to(:user) }
end
