FactoryGirl.define do
  factory :user do
    twitter_user = Faker::Omniauth.twitter
    uid twitter_user[:uid]
    token twitter_user[:credentials][:token]
    secret twitter_user[:credentials][:secret]
    connected false
  end
end
