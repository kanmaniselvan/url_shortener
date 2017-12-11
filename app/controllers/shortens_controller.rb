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
    shorten_url = ShortenUrl.where(short_code: params[:id]).first

    if shorten_url.blank?
      flash[:error] = 'Invalid Short Code!'
      redirect_to shortens_path
    end

    shorten_url.update_last_seen_and_redirect_count

    redirect_to shorten_url.url

  rescue StandardError => ex
    flast[:error] = ex
    redirect_to shortens_path
  end

  private
  def shorten_params
    params.permit(:url, :short_code)
  end
end
