module EmailTracker
  class EmailInstancesController < ApplicationController

    skip_before_filter :check_logged_in, :only => :opened

    def opened
      # Get the instance from the url code
      @instance = EmailTracker::EmailInstance.where(url_code: params[:url_code]).order("id DESC").first
    
      # If this hasn't been found, it may be due to a legacy issue
      # where we used to search by id
      unless @instance
        # Search by id
        @instance = EmailTracker::EmailInstance.find_by_id(params[:url_code])
      
        # If the instance doesn't exist, or it has a url code (and is therefore post this change) then get out of here
        unless @instance && @instance.url_code == ""
          redirect_to root_path
          return
        end
      end
    
      # Mark the instance as opened
      @instance.opened!
    
      # And send the required image data back
      send_data(File.read(File.expand_path("../../../assets/images/email_tracker/transparent.png",  __FILE__)))
    end

  end
end