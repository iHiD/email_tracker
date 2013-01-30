require "email_tracker/engine"
require "email_tracker/helpers"

module EmailTracker
  
  def self.hash_email_address(email)
    Base64.encode64(email).strip[0...-1]
  end
  
  def self.retrieve_email_address_from_hash(hash)
    Base64.decode64("#{hash}=")
  end
  
end
