FactoryGirl.define do
  factory :link, class: EmailTracker::Link do
    url "/foobar"
  end
end