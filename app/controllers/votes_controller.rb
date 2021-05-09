class VotesController < ApplicationController
  before_action :set_vote, only: :destroy

  # POST /votes
  def create
    @vote = Vote.new(vote_params)
    @path = params[:path]

    if @vote.save
      redirect_to @path
    else
      redirect_to @path, alert: 'You cannot vote for this recipe.'
    end
  end

  # DELETE /votes/1
  def destroy
    @vote.destroy
    @path = params[:path]
    redirect_to @path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vote
    @vote = Vote.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vote_params
    params.require(:vote).permit(:opinion_id, :user_id)
  end
end
