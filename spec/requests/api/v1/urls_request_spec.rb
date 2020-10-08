require 'rails_helper'

RSpec.describe "Api::V1::Urls", type: :request do
  before do
    post '/api/v1/urls', params: {
      url: {
        original: 'https://test-very-long-url.com'
      }
    }
  end
  
  it 'returns the short url' do
    expect(JSON.parse(response.body)['url']['short_url']).to eq('http://0.try')
    expect(JSON.parse(response.body)['url']['original_url']).to eq('https://test-very-long-url.com')
  end
end

RSpec.describe "Api::V1::Urls", type: :request do
  before do
    post '/api/v1/urls/original', params: {
      url: {
        short_url: 'http://0.try'
      }
    }
  end
  
  it 'returns the original url' do
    expect(JSON.parse(response.body)['url']['short_url']).to eq('http://0.try')
    expect(JSON.parse(response.body)['url']['original_url']).to eq('https://test-very-long-url.com')
  end
end
