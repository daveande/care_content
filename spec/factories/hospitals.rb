FactoryGirl.define do
  factory :hospital do
    name 'Detroit Medical'
    address '1234 Main Street'
    city 'Detroit'
    state 'MI'
    zip '48207'
    association :service_area
  end
end
