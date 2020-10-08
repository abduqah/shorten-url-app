require 'rails_helper'

RSpec.describe "Api::V1::Urls", type: :request do
  context 'request url shortening' do
    before do
      post '/api/v1/urls', params: {
        url: {
          original: 'https://test-very-long-url.com'
        }
      }
    end
    
    it 'returns the short url' do
      expect(JSON.parse(response.body)['url']['short']).to eq('http://0.try')
      expect(JSON.parse(response.body)['url']['original']).to eq('https://test-very-long-url.com')
    end
  end

  context 'request retrieval of original url' do
    let(:url) { create(:url) }
    
    before do
      post '/api/v1/urls/original', params: {
        url: {
          short: url.short_url
        }
      }
    end
    
    it 'returns the original url' do
      expect(JSON.parse(response.body)['url']['short']).to eq(url.short_url)
      expect(JSON.parse(response.body)['url']['original']).to eq(url.url)
    end
  end
end
