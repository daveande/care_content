FactoryGirl.define do
  factory :plan do
    max_downloads 2
    downloads_per 'year'
    price 500
    genre 'A la Carte'
    name '2/year'
  end
end
