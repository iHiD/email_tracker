# encoding: UTF-8
require 'spec_helper'

describe "Email Tracking Navigation" do
  
  it "should respond to et_open" do
    email = FactoryGirl.create(:email)
    hashed_email = Base64.encode64("jez.walker@gmail.com").strip
    lambda {
      visit "/et/#{email.id}/#{hashed_email}"
    }.should change(EmailTracker::EmailOpen, :count).by(1)
    
    page.response_headers["Content-Type"].should == "application/octet-stream"
      
    open = EmailTracker::EmailOpen.last
    open.email_id.should == email.id
    open.email_address.should == "jez.walker@gmail.com"
  end
  
  it "should check for an et param on any page open" do
    email = FactoryGirl.create(:email)
    hashed_email = Base64.encode64("jez.walker@gmail.com").strip

    lambda {
      visit "/foobar?et=#{email.id}_#{hashed_email}"
    }.should change(EmailTracker::LinkClick, :count).by(1)
    
    page.current_url.should == "http://www.example.com/foobar"
    
    click = EmailTracker::LinkClick.last
    click.email_id.should == email.id
    click.email_address.should == "jez.walker@gmail.com"
    click.url.should == "/foobar"
  end
end