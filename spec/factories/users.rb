FactoryGirl.define do
  factory :user do
    before(:create) do |user|
      user.skip_confirmation!
    end
    sequence :email do |n|
      "test#{n}@example.com"
    end
    password 'password'
    ignore do
      confirmed true
    end
  end
end