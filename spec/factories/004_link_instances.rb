FactoryGirl.define do
  factory :link_instance, class: EmailTracker::LinkInstance do
    email_instance FactoryGirl.create(:email_instance)
    link           FactoryGirl.create(:link)
  end
end