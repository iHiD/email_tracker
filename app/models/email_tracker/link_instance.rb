'digest/sha1'
module EmailTracker
  class LinkInstance < ActiveRecord::Base
  
    belongs_to :email_instance
    has_one :email, through: :email_instance
    has_one :user, through: :email_instance
    belongs_to :link
  
    scope :clicked, where("clicked_at IS NOT NULL")
  
    before_create do
      self.url_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
  
    def clicked?
      clicked_at != nil ? true : false
    end
  
    def clicked!
      unless clicked?
        self.clicked_at = DateTime.now
        save!
      end
      true
    end
  
  end
end