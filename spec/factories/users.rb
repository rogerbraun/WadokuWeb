# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "email#{n}@example.com"}
    password "Anything"
    password_confirmation {|user| user.password}
  end
end
