FactoryBot.define do
  factory :url, class: ShortenUrl::ShortUrl do
    url { FFaker::Internet.unique.http_url }
  end
end
