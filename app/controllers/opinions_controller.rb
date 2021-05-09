class OpinionsController < ApplicationController
  # GET /opinions
  def index
    timeline_opinions
    @opinion = Opinion.new
  end

  # POST /opinions
  def create
    @opinion = Opinion.new(opinion_params)

    if @opinion.save
      redirect_to root_path, notice: 'Opinion was successfully created.'
    else
      timeline_opinions
      render :index, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def opinion_params
    params.require(:opinion).permit(:author_id, :text)
  end

  def timeline_opinions
    @timeline_opinions ||= current_user.opinions_from_followed_users.ordered_by_most_recent.includes(:author)
  end
end
