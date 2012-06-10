Rails.application.routes.draw do 
  match "et_open/:url_code" => "email_tracker/email_instances#opened", as: "email_tracking_email_opened"
  match "et_click/:url_code" => "email_tracker/link_instances#clicked", as: "email_tracking_link_clicked"
end

EmailTracker::Engine.routes.draw do
end
