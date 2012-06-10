Rails.application.routes.draw do
  mount EmailTracker::Engine => "/email_tracker"
end
