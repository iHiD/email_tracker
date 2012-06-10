module EmailTracker
  class LinkInstancesController < ApplicationController

    skip_before_filter :check_logged_in, :only => :clicked

    def clicked
      # Get the instance from the url code
      @instance = EmailTracker::LinkInstance.where(url_code: params[:url_code]).order("id DESC").first
    
      # If this hasn't been found, it may be due to a legacy issue
      # where we used to search by id
      unless @instance
        # Search by id
        @instance = EmailTracker::LinkInstance.find_by_id(params[:url_code])
      
        # If the instance doesn't exist, or it has a url code (and is therefore post this change) then get out of here
        unless @instance && @instance.url_code == ""
          redirect_to root_path
          return
        end
      end
    
      # We have a valid instance, so mark it as clicked
      @instance.clicked!
      redirect_to @instance.link.url
      
=begin    
      # If we don't have a user model to care about, just leave
      return unless Module.const_defined?(:User)
      
      # Otherwise check whether the user can view this page and act accordingly
      if @instance.is_externally_viewable? || 
         !@instance.user || 
         (responds_to(:user_logged_in?) && user_logged_in?) || 
         (responds_to(:logged_in?) && logged_in?)
      else 
        store_user_location(@instance.link.url) 
        @new_user = @instance.user
      end
=end
    end
  end
end