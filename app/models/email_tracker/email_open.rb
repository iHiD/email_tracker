require 'digest/sha1'
module EmailTracker
  class EmailOpen < ActiveRecord::Base
    
    attr_accessible :email_id, :email_address_hash, as: :email_tracker_internals
  
    belongs_to :email
    
    def email_address_hash=(hash)
      self.email_address = EmailTracker.retrieve_email_address_from_hash(hash)
    end
  end
end