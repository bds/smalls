class TrackedUrlsController < ApplicationController
  rescue_from Addressable::URI::InvalidURIError do
    render :nothing => true, :status => 400
  end

  rescue_from ActiveRecord::RecordNotFound do
    render :nothing => true, :status => 404
  end

  def create
    tracked_url = shortener.call!
    render json: tracked_url
  end

  def show
    redirect_to tracked_url.long_url, status: :moved_permanently
  end

  def new; end

  private

  def shortener
    UrlShortener.new(allowed_params)
  end

  def tracked_url
    TrackedUrl.find_by!(slug: params[:slug])
  end

  def allowed_params
    params.require(:long_url)
  end
end
