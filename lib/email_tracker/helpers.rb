module EmailTracker
  
  module Helpers
    
    def self.included(base)
      base.before_filter :check_for_email_tracker
    end
    
    protected
    
      def check_for_email_tracker
        
        begin
          if params[:et]
            
            path_without_tracking = request.fullpath.gsub("et=#{CGI.escape(params[:et])}", "").gsub(/[\&\?]$/, "")
            
            email_id, email_address_hash = params[:et].split("_")
            EmailTracker::LinkClick.create({
              email_id: email_id,
              email_address_hash: email_address_hash,
              url: path_without_tracking
            }, as: :email_tracker_internals)
            
            redirect_to path_without_tracking
          end
        rescue
          logger.info $!
        end
        true
      end
  end
  
end