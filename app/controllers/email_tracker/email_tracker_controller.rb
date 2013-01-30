module EmailTracker
  class EmailTrackerController < ActionController::Base

    skip_before_filter :check_logged_in, :only => :opened

    def opened
      email = Email.find(params[:email_id])
      email.opens.create!({email_address_hash: params[:email_hash]}, as: :email_tracker_internals)
      send_data(File.read(File.expand_path("../../../assets/images/email_tracker/transparent.png",  __FILE__)))
    end

  end
end