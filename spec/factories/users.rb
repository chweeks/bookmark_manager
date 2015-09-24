FactoryGirl.define do
  factory :user do
    email 'alice@example.com'
    password 'apples!'
    password_confirmation 'apples!'
  end
end
