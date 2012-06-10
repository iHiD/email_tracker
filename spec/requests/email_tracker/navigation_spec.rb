require 'spec_helper'

describe "Email Tracking Navigation" do
  
  it "should respond to et_open" do
    instance = FactoryGirl.create(:email_instance)
    instance.opened?.should == false
    
    # Should return an image
    lambda {visit "/et_open/#{instance.url_code}"}.should raise_error(ArgumentError, "invalid byte sequence in UTF-8")
    instance.reload
    instance.opened?.should == true
  end
  
end

