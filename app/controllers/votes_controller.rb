class VotesController < ApplicationController
  before_action :set_vote, only: :destroy

  # POST /votes
  def create
    @vote = vote.new(vote_params)

    if @vote.save
      redirect_to @vote.path, notice: 'You voted for this recipe.'
    else
      redirect_to @vote.path, alert: 'You cannot vote for this recipe.'
    end
  end

  # DELETE /votes/1
  def destroy
    user_id = @vote.user_id
    @vote.destroy
    redirect_to @vote.path, notice: 'You have unvoted this recipe.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vote
    @vote = Vote.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vote_params
    params.require(:vote).permit(:opinion_id, :user_id, :path)
  end
end
