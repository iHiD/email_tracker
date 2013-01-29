'digest/sha1'
module EmailTracker
  class LinkClick < ActiveRecord::Base
  
    belongs_to :email
    belongs_to :user
    
    attr_accessible :email_id, :email_address, :url, as: :email_tracker_internals
  
    def self.for_url(url)
      self.find_or_create_by_url(url)
    end
  end
end