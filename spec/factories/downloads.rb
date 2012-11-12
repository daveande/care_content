FactoryGirl.define do
  factory :download do
    association :user
    association :content_file
    association :service_area
    association :purchase
  end
end
