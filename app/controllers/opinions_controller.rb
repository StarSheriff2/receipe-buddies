class OpinionsController < ApplicationController
  before_action :set_opinion, only: %i[show edit update destroy]

  # GET /opinions
  def index
    @opinions = Opinion.all
    @opinion = Opinion.new
  end

  # GET /opinions/1
  def show; end

  # GET /opinions/new
  def new
    @opinion = Opinion.new
  end

  # POST /opinions
  def create
    @opinion = Opinion.new(opinion_params)

    if @opinion.save
      redirect_to @opinion, notice: 'Opinion was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_opinion
    @opinion = Opinion.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def opinion_params
    params.require(:opinion).permit(:author_id, :text)
  end
end
