module EmailTracker
  class Interceptor
    
    def initialize(message)
      @message = message
      @hashed_email_address = EmailTracker.hash_email_address(Array(message.to).first)
      @email = EmailTracker::Email.for_email(message.tracking_data)
      
      opts = Rails.application.config.action_mailer.default_url_options
      protocol = opts.fetch(:protocol, "https")
      host = opts.fetch(:host)
      @url_base = "#{protocol}://#{host}"
      
      if message.multipart?
        message.html_part.body = add_tracking(message.html_part.body)
      else
        message.body = add_tracking(message.body)
      end
      
      @email.sent!
    end
    
    def add_tracking(content)
      begin
        add_tracking_links(add_tracking_image(content.to_s))
      rescue
        p $!
      end
    end
    
    def add_tracking_image(content)
      tracking_url = "#{@url_base}/et/#{@email.id}/#{@hashed_email_address}.gif"
      tracking_html = "<img src=\"#{tracking_url}\" alt=\"\"/>"
      content.gsub("</body>", "#{tracking_html}</body>")
    end
    
    def add_tracking_links(content)
      content.gsub!(/href\=['"]([^"']+)['"]/) do |match|
        url = $1
        if url.starts_with?("mailto")
          match
        else
          join_symbol = url.include?("?") ? "&" : "?"
          url = "href=\"" + (url.starts_with?("http") ? "" : @url_base) + "#{url}#{join_symbol}et=#{@email.id}_#{@hashed_email_address}\""
        end
      end
      
      content
    end
    
    def self.delivering_email(message)
      self.new(message)
    end
  end
end