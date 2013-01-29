Rails.application.routes.draw do 
  match "et/:email_id/:email_hash" => "email_tracker/email_tracker#opened", as: "email_tracker_opened"
  match "et_click/:url_code" => "email_tracker/link_instances#clicked", as: "email_tracking_link_clicked"
end

EmailTracker::Engine.routes.draw do
end
