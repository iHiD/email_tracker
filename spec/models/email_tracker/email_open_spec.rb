require 'spec_helper'
module EmailTracker
  describe EmailOpen do 
    it "should create with a hashed_email" do
      email = FactoryGirl.create(:email)
      email_address = "jez.walker@gmail.com"
      
      email_open = EmailOpen.create({email_id: email.id, email_address_hash: EmailTracker.hash_email_address(email_address)}, as: :email_tracker_internals)
      email_open.should_not be_new_record
      email_open.email.should == email
      email_open.email_address.should == email_address
    end
  end
end