require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Urls" do

  explanation "Urls resource"

  post "/api/v1/urls" do
    with_options scope: :url, with_example: true do
      parameter :original, 'Original url', required: true
    end

    context '200' do
      let(:original_url) { FFaker::Internet.http_url }
      example "Requesting url shortening" do
        request = {
          url: {
            original: original_url
          }
        }

        do_request(request)

        expected_response = {
          'url' => {
            'original' => original_url,
            'short' => 'http://0.try'
          }
        }

        expect(status).to eq 200
        expect(JSON.parse(response_body)).to eq(expected_response)
      end
    end
  end

  post "/api/v1/urls/original" do
    with_options scope: :url, with_example: true do
      parameter :short, 'Short url', required: true
    end

    context '200' do
      let(:url) { create(:url) }

      example "Requesting url shortening" do
        request = {
          url: {
            short: url.short_url
          }
        }

        do_request(request)

        expected_response = {
          'url' => {
            'original' => url.url,
            'short' => url.short_url
          }
        }

        expect(status).to eq 200
        expect(JSON.parse(response_body)).to eq(expected_response)
      end
    end

    context '422' do
      example "Requesting url shortening with not valid short url" do
        request = {
          'url' => {
            'short' => 'http://nt-s.try'
          }
        }

        do_request(request)

        expected_response = {
          'errors' => [
            "Sorry we couldn't resolve your short URL"
          ]
        }

        expect(status).to eq 422
        expect(JSON.parse(response_body)).to eq(expected_response)
      end
    end
  end
end
