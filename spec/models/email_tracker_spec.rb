require 'spec_helper'
describe EmailTracker do
  
  describe "email hashing" do
    
    before :each do 
      @email_hash = ["jez.walker@gmail.com", "amV6LndhbGtlckBnbWFpbC5jb20="]
    end
    
    it "should hash an email address" do
      EmailTracker.hash_email_address(@email_hash[0]).should == @email_hash[1]
    end
    it "should retrieve an email address from a hash" do
      EmailTracker.retrieve_email_address_from_hash(@email_hash[1]).should == @email_hash[0]
    end
  end
end