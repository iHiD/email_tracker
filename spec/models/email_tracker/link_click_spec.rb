require 'spec_helper'
module EmailTracker
  describe LinkClick do 
    it "should create with a hashed_email" do
      email = FactoryGirl.create(:email)
      email_address = "jez.walker@gmail.com"
      
      link_click = LinkClick.create({
        email_id: email.id, 
        email_address_hash: EmailTracker.hash_email_address(email_address),
        url: "/foobar"
      }, as: :email_tracker_internals)
      link_click.should_not be_new_record
      link_click.email.should == email
      link_click.email_address.should == email_address
      link_click.url.should == "/foobar"
    end
  end
end