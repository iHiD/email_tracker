FactoryGirl.define do
  factory :email_instance, class: EmailTracker::EmailInstance do
    email_address "jez.walker@gmail.com"
    email FactoryGirl.create(:email)
  end
end