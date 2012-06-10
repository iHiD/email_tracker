Rails.application.routes.draw do
  mount EmailTracker::Engine => "/email_tracker"
  
  match "/foobar" => 'test#test'
end
