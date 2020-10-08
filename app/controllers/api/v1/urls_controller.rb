module Api::V1
  class UrlsController < ApplicationController

    def create
      record = ShortenUrl::ShortUrl.shorten(url: url_shortener_params[:original])

      render json: {
        url: {
          original: url_shortener_params[:original],
          short: record
        }
      }
    end

    def original
      record = ShortenUrl::ShortUrl.resolve(short_url: url_originator_params[:short])

      render json: {
        errors: [
          "Sorry we couldn't resolve your short URL"
        ]
      }, status: :unprocessable_entity and return unless record

      render json: {
        url: {
          original: record,
          short: url_originator_params[:short]
        }
      }
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
