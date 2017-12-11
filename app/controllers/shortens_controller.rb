class ShortensController < ApplicationController
  before_action :require_shorten_url, only: [:show, :edit, :update, :destroy]

  def index
    @shorten_urls = current_user.shorten_urls
  end

  def new
    @shorten_url = ShortenUrl.new
  end

  def create
    @shorten_url = ShortenUrl.new(shorten_params)

    if @shorten_url.save
      flash[:success] = 'Created Successfully!'

      redirect_to shortens_path
    else
      flash.now[:error] = @shorten_url.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @shorten_url.update_last_seen_and_redirect_count

    redirect_to @shorten_url.url
  end

  def edit
    render :new
  end

  def update
    if @shorten_url.update_attributes(shorten_params)
      flash[:success] = 'Updated Successfully!'

      redirect_to shortens_path
    else
      flash.now[:error] = @shorten_url.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    @shorten_url.destroy!

    flash[:success] = 'Deleted Successfully!'

    redirect_to shortens_path
  end

  private
  def shorten_params
    params.require(:shorten_url).permit(:url, :short_code).tap do |param|
      param[:user_id] = current_user.id
    end
  end

  def require_shorten_url
    @shorten_url = ShortenUrl.where(short_code: params[:id]).first

    if @shorten_url.blank?
      flash[:error] = 'Invalid Short Code!'
      redirect_to shortens_path and return false
    end

    @shorten_url
  end
end
