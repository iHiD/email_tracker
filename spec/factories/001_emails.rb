FactoryGirl.define do
  factory :email, class: EmailTracker::Email do
    mailer "My/Mailer"
    action "my_action"
    subject "My Subject"
  end
end