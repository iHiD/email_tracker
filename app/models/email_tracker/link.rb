module EmailTracker
  class Link < ActiveRecord::Base
  
    has_many :instances, class_name: "EmailTracker::LinkInstance"
  
    def self.for_url(url)
      self.find_or_create_by_url(url)
    end
  end
end
