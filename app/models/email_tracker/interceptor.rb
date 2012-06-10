module EmailTracker
  class Interceptor
    def self.delivering_email(message)
    
      if message.multipart?
        message.html_part.body = add_tracking(message, message.html_part.body.to_s)
      else
        message.body = add_tracking(message, message.body.to_s)
      end
    end
    
    def self.add_tracking(message, content)
      begin
        # Get tracking data, and the recipient
        tracking_data = message.tracking_data
        email_address = Array(message.to).first
      
        if tracking_data[:owner]
          tracking_data[:owner_type] = tracking_data[:owner].class.name
          tracking_data[:owner_id] = tracking_data[:owner].id
        end
  
        # Get or create a tracked version of this email
        tracking_email = EmailTracker::Email.for_email(tracking_data)
    
        # And create a new instance for this email address (and user if specified)
        tracking_email_instance = tracking_email.create_instance!(email_address, tracking_data[:user_id])
        
        # Get url options
        opts = Rails.application.config.action_mailer.default_url_options
        protocol = opts.fetch(:protocol, "http")
        host = opts.fetch(:host)
        url_base = "#{protocol}://#{host}/"
    
        # Modify html to track open
        tracking_url = "#{url_base}et_open/#{tracking_email_instance.url_code}.gif"
        tracking_html = "<img src=\"#{tracking_url}\" alt=\"\"/>"
        content.gsub!("<body>", "<body>#{tracking_html}")
        
        # Modify html to track clicks
        content.gsub!(/href\=['"]([^"']+)['"]/) do |match|
          url = $1
          if url.starts_with?("mailto")
            match
          elsif url.match("et_notrack=true")
            ""
          else
            if external = !!url.match("et_external=true")
              url.gsub!("et_external=true", "")
            end
          
            tracked_link = EmailTracker::Link.for_url(url)
            tracked_link_instance = tracked_link.instances.create!({email_instance: tracking_email_instance, is_externally_viewable: external}, as: :email_tracker_internals)
            url = "#{url_base}et_click/#{tracked_link_instance.url_code}"
            "href=\"#{url}\""
          end
        end
      rescue
        p $!
      end
      
      content
    end
  end
end