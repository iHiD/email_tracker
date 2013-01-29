FactoryGirl.define do
  factory :email_opens, class: EmailTracker::EmailOpen do
    email FactoryGirl.create(:email)
    user stub(:user)
  end
end