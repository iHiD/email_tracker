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
        hashed_email_address = Base64.encode64(email_address).strip[0...-1]
      
        if tracking_data[:owner]
          tracking_data[:owner_type] = tracking_data[:owner].class.name
          tracking_data[:owner_id] = tracking_data[:owner].id
        end
  
        # Get or create a tracked version of this email
        tracking_email = EmailTracker::Email.for_email(tracking_data)
        tracking_email.sent!

        # Get url options
        opts = Rails.application.config.action_mailer.default_url_options
        protocol = opts.fetch(:protocol, "http")
        host = opts.fetch(:host)
        url_base = "#{protocol}://#{host}"
    
        # Modify html to track open
        tracking_url = "#{url_base}/et/#{tracking_email.id}/#{hashed_email_address}.gif"
        tracking_html = "<img src=\"#{tracking_url}\" alt=\"\"/>"
        content.gsub!("</body>", "#{tracking_html}</body>")
        
        # Modify html to track clicks
        tracked_link_instances = []
        tracked_url_links = {}
        content.gsub!(/href\=['"]([^"']+)['"]/) do |match|
          url = $1
          if url.starts_with?("mailto")
            match
          else
            join_symbol = url.include?("?") ? "&" : "?"
            url = "href=\"" + (url.starts_with?(protocol) ? "" : url_base) + "#{url}?et=#{tracking_email.id}_#{hashed_email_address}\""
          end
        end
      rescue
        p $!
      end
      
      content
    end
  end
end