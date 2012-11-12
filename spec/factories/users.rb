FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@example.com"}
    password 'please'
    password_confirmation 'please'
    first_name 'David'
    last_name 'Anderson'
    association :hospital
  end
end


