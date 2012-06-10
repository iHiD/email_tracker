require 'spec_helper'
module EmailTracker
  describe EmailInstance do 
    
    it "scoped should work correctly" do
      FactoryGirl.create(:email_instance)
      FactoryGirl.create(:email_instance)
      FactoryGirl.create(:email_instance).update_attribute(:opened_at, DateTime.now)
      EmailInstance.opened.count.should == 1
    end
    
    it "should set url_code" do
      FactoryGirl.create(:email_instance).url_code.should_not be_empty
    end
    
    it "should correctly return opened?" do
      FactoryGirl.create(:email_instance).opened?.should == false
      
      instance = FactoryGirl.create(:email_instance)
      instance.update_attribute(:opened_at, DateTime.now)
      instance.opened?.should == true
    end
    
    it "should correctly set opened" do
      instance = FactoryGirl.create(:email_instance)
      instance.opened?.should == false
      instance.opened!
      instance.opened?.should == true
    end
    
  end
end
