require 'digest/sha1'
module EmailTracker
  class EmailInstance < ActiveRecord::Base
  
    belongs_to :email
    belongs_to :user
    has_many :link_instances
    
    scope :opened, where("opened_at IS NOT NULL")
    
    before_create do 
      #self.user     = User.where(email: self.email_address).select(:id).first unless self.user_id
      self.url_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
      true
    end
    
    def opened?
      opened_at != nil ? true : false
    end
    
    def opened!
      unless opened?
        self.opened_at = DateTime.now
        save!
     end
    end
  end
end