class ShortensController < ApplicationController
  def index

  end

  def create
    ShortenUrl.create!(shorten_params)

    render :index
  rescue StandardError => ex
    flast.now[:error] = ex
    render :index
  end

  def show

  end

  private
  def shorten_params
    params.permit(:url, :short_code)
  end
end
