FactoryGirl.define do
  factory :email, class: EmailTracker::Email do
    mailer "My/Mailer"
    action "my_action"
  end
end