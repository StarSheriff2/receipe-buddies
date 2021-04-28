class OpinionsController < ApplicationController
  before_action :set_opinion, only: %i[ show edit update destroy ]

  # GET /opinions
  def index
    @opinions = Opinion.all
  end

  # GET /opinions/1
  def show
  end

  # GET /opinions/new
  def new
    @opinion = Opinion.new
  end

  # GET /opinions/1/edit
  def edit
  end

  # POST /opinions
  def create
    @opinion = Opinion.new(opinion_params)

    if @opinion.save
      redirect_to @opinion, notice: "Opinion was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /opinions/1
  def update
    if @opinion.update(opinion_params)
      redirect_to @opinion, notice: "Opinion was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /opinions/1
  def destroy
    @opinion.destroy
    redirect_to opinions_url, notice: "Opinion was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opinion
      @opinion = Opinion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def opinion_params
      params.fetch(:opinion, {})
    end
end
