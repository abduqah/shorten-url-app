FactoryBot.define do
  factory :url do
    url { FFaker::Internet.unique.http_url }
  end
end
