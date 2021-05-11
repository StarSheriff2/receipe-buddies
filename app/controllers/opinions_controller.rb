class OpinionsController < ApplicationController
  def index
    @opinion = Opinion.new
  end

  def create
    @opinion = Opinion.new(opinion_params)

    if @opinion.save
      redirect_to root_path, notice: 'Opinion was successfully created.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def opinion_params
    params.require(:opinion).permit(:author_id, :text)
  end
end
