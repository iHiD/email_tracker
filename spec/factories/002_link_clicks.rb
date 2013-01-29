FactoryGirl.define do
  factory :link, class: EmailTracker::LinkClick do
    url "/foobar"
    email FactoryGirl.create(:email)
    user stub(:user)
  end
end