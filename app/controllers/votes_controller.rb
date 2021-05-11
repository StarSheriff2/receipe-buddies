class VotesController < ApplicationController
  before_action :set_vote, only: :destroy

  def create
    @vote = Vote.new(vote_params)
    @path = params[:path]

    if @vote.save
      redirect_to @path
    else
      redirect_to @path, alert: 'You cannot vote for this recipe.'
    end
  end

  def destroy
    @vote.destroy
    @path = params[:path]
    redirect_to @path
  end

  private

  def set_vote
    @vote = Vote.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:opinion_id, :user_id)
  end
end
