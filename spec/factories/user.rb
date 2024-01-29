FactoryBot.define do
  factory :user do
    name                  { "John Doe" }
    email                 { "john@example.com" }
    crypted_password      { "encrypted_password" }
    avatar                { "path_to_avatar.png" }
    role                  { 1 }
    prefecture_id         { 1 }
    created_at            { Time.now }
    updated_at            { Time.now }
    salt                  { "somesalt" }
    remember_me_token     { "some_token" }
    remember_me_token_expires_at { Time.now + 1.week }
    reset_password_token  { "reset_token" }
    reset_password_token_expires_at { Time.now + 1.hour }
    reset_password_email_sent_at { Time.now }
    access_count_to_reset_password_page { 0 }
  end
end