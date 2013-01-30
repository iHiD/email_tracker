module EmailTracker
  class Email < ActiveRecord::Base
  
    belongs_to :owner, polymorphic: true
  
    has_many :opens, class_name: "EmailOpen"
    has_many :clicks, class_name: "LinkClick"
    
    attr_accessible :owner, :owner_type, :owner_id, :mailer, :action, :subject, as: :email_tracker_internals
  
    def sent!
      increment!(:times_sent)
    end

    def times_opened(since = nil)
      o = opens.scoped
      o = o.where("created_at > ?", since) if since
      o.count
    end

    def opened_percentage(since = nil)
      ((times_opened(since).to_f / times_sent) * 100).to_i
    end

    def num_links_clicked(since = nil)
      c = clicks.scoped
      c = c.where("created_at > ?", since) if since
      c.count
    end
    
    def self.for_email(data)
     
      if data[:owner]
        data[:owner_type] = data[:owner].class.name
        data[:owner_id] = data[:owner].id
      end
      
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