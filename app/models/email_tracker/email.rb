module EmailTracker
  class Email < ActiveRecord::Base
  
    belongs_to :owner, polymorphic: true
  
    has_many :instances, class_name: "EmailInstance"
    has_many :link_instances, through: :instances
    
    attr_accessible :owner, :owner_type, :owner_id, :mailer, :action, as: :email_tracker_internals
    
    before_create :set_default_name
    before_create :set_default_description
  
    def self.for_email(data)
    
      hash = {
        mailer: data[:mailer],
        action: data[:action],
        owner_type: data[:owner_type],
        owner_id: data[:owner_id]
      }
    
      if email = self.where(hash).first
        return email
      end
    
      email = self.new(hash, as: :email_tracker_internals)
      email.save!
      email
    end
  
  def create_instance!(email_address, user_id)
    instances.create!({email_address: email_address, user_id: user_id}, as: :email_tracker_internals)
  end
  
    private
  
    def set_default_name
      self.name = if owner
        if owner.respond_to?(:name)
          owner.name
        elsif owner.respond_to?(:title)
          owner.title
        else
          "#{owner.class.name.humanize.capitalize} ##{owner.id}"
        end
      else
        "#{mailer.split("/").last.capitalize} #{action.humanize}"
      end
      true
    end
    
    def set_default_description
      self.description = ""
      true
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