require 'spec_helper'

describe EmailTracker do
  it "should be a module" do
    EmailTracker.should be_kind_of Module
  end
  
  it "should add tracking_data to Mail:Message" do
    Mail::Message.new.should respond_to :tracking_data
    Mail::Message.new.should respond_to :tracking_data=
  end
  
  describe "ActionMailer::Base" do
  
    it "should add alias mail as mail_without_tracking" do
      TestMailer.send(:new).should respond_to :mail_without_tracking
    end
  end
end