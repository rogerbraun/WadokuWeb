FactoryGirl.define do

  factory :entry do
    sequence(:romaji){|n| "Something #{n}"}
    sequence(:wadoku_id){|n| n}
  end
end
