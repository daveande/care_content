FactoryGirl.define do
  factory :purchase do
    association :plan
    association :user
    period_end Time.now() + 1.years
    expired false
    agreed_to_terms true
  end
end
