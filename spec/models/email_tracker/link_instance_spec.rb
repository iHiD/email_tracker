require 'spec_helper'
module EmailTracker
  describe LinkInstance do 
    
    it "scoped should work correctly" do
      FactoryGirl.create(:link_instance)
      FactoryGirl.create(:link_instance)
      FactoryGirl.create(:link_instance).update_attribute(:clicked_at, DateTime.now)
      LinkInstance.clicked.count.should == 1
    end
    
    it "should set url_code" do
      FactoryGirl.create(:link_instance).url_code.should_not be_empty
    end
    
    it "should correctly return clicked?" do
      FactoryGirl.create(:link_instance).clicked?.should == false
      
      instance = FactoryGirl.create(:link_instance)
      instance.update_attribute(:clicked_at, DateTime.now)
      instance.clicked?.should == true
    end
    
    it "should correctly set clicked" do
      instance = FactoryGirl.create(:link_instance)
      instance.clicked?.should == false
      instance.clicked!
      instance.clicked?.should == true
    end
    
  end
end
