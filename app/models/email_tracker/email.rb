module EmailTracker
  class Email < ActiveRecord::Base
  
    belongs_to :owner, polymorphic: true
  
    has_many :opens, class_name: "EmailOpen"
    has_many :clicks, class_name: "LinkClick"
    
    attr_accessible :owner, :owner_type, :owner_id, :mailer, :action, :subject, as: :email_tracker_internals
  
    def sent!
      increment!(:times_sent)
    end
    
    def self.for_email(data)
     
      hash = {
        mailer: data[:mailer],
        action: data[:action],
        subject: data[:subject],
        owner_type: data[:owner_type],
        owner_id: data[:owner_id]
      }
       
      unless email = self.where(hash).first
        email = self.new(hash, as: :email_tracker_internals)
        email.save!
      end
    
      email
    end
  end
end  
=begin


  def times_sent(since = nil)
    i = instances
    i = i.where("created_at > ?", since) if since
    i.count
  end

  def times_opened(since = nil)
    i = instances.opened
    i = i.where("opened_at > ?", since) if since
    i.count
  end

  def opened_percentage(since = nil)
    ((times_opened(since).to_f / times_sent(since)) * 100).to_i
  end

  def num_links_clicked(since = nil)
    i = link_instances.clicked
    i = i.where("clicked_at > ?", since) if since
    i.count
  end
end

=end