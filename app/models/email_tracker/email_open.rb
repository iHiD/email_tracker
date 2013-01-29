require 'digest/sha1'
module EmailTracker
  class EmailOpen < ActiveRecord::Base
    
    attr_accessible :email_address, as: :email_tracker_internals
  
    belongs_to :email
    belongs_to :user
  end
end