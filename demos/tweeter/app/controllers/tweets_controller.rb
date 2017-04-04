class TweetsController < ApplicationController

  # See https://stackoverflow.com/questions/9362910/rails-warning-cant-verify-csrf-token-authenticity-for-json-devise-requests/10049965#10049965
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  skip_before_action :verify_authenticity_token, if: Proc.new { |c| c.request.format == 'application/json' }

  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    logger.debug "params => #{params.inspect}"

    respond_to do |format|
      format.html do
        logger.debug "tweet_params => #{tweet_params.inspect}"
        @tweet = Tweet.new(tweet_params)

        if @tweet.save
          redirect_to @tweet, notice: 'Tweet was successfully created.'
        else
          render :new
        end
      end
      format.json do
        @tweet = Tweet.new(params.permit(:handle, :content))

        if @tweet.save
          render :show, status: :created, location: @tweet
        else
          render json: @tweet.errors, status: :unprocessable_entity
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:handle, :content)
    end
end
