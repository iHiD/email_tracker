module EmailTracker
  
  module Helpers
    
    def self.included(base)
      base.before_filter :check_for_email_tracker
    end
    
    protected
    
      def check_for_email_tracker
        if params[:et]
          email_id, email_hash = params[:et].split("_")
          email_address = Base64.decode64("#{email_hash}=")
          EmailTracker::LinkClick.create({
            email_id: email_id,
            email_address: email_address,
            url: request.fullpath.gsub("et=#{params[:et]}", "")[0...-1]
          }, as: :email_tracker_internals)
        end
        true
      end
  end
  
end