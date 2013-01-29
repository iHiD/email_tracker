require 'mail'

# Register the interceptor, observer and subscribers
# These all do different things to the message at different stages
Mail.register_interceptor(EmailTracker::Interceptor)

# Add a private variable :tracking_data
class Mail::Message
  attr_accessor :tracking_data
end

class ActionMailer::Base
  alias_method :mail_without_tracking, :mail
  
  # Modifies mail() so headers can take the hash :tracking_data
  # which contains extra data to be tracked
  def mail(headers = {}, &block)
    
    # Extra tracking data can be passed via :tracking_data in the headers
    tracking_data = headers.delete(:tracking_data) || {}
    
    # Store the mailer as the current class name underscored
    tracking_data[:mailer] ||= self.class.name.underscore
    
    # Store the action as the method that has called mail()
    # This can be overriden by passing :action as part of tracking_data
    tracking_data[:action] ||= caller[0][/`([^']*)'/, 1]
    
    tracking_data[:subject] ||= headers[:subject]
    
    # Call the original method and add the tracking_data
    message = mail_without_tracking(headers, &block)
    message.tracking_data = tracking_data
    message
  end
end