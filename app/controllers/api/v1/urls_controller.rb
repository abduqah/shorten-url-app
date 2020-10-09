module Api::V1
  class UrlsController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      record = ShortenUrl::ShortUrl.shorten(url: url_shortener_params[:original])

      respond_to do |format|
        format.html { redirect_to(url_path(record), notice: 'URL shortened!') }
        format.json {
          render json: {
            url: {
              original: url_shortener_params[:original],
              short: record
            }
          }
        }
      end
    end

    def original
      record = ShortenUrl::ShortUrl.resolve(short_url: url_originator_params[:short])

      unless record
        respond_to do |format|
          format.html { redirect_to(new_url_path, alert: "Sorry we couldn't resolve your short URL") }
          format.json {
            render json: {
              errors: [
                "Sorry we couldn't resolve your short URL"
              ]
            }, status: :unprocessable_entity
          }
        end
      else
        respond_to do |format|
          format.html { redirect_to(url_path(url_originator_params[:short]), notice: 'Your URL, retrieved!') }
          format.json {
            render json: {
              url: {
                original: record,
                short: url_originator_params[:short]
              }
            }
          }
        end
      end
    end

    private

    def url_shortener_params
      params.require(:url).permit(:original)
    end

    def url_originator_params
      params.require(:url).permit(:short)
    end
  end
end
