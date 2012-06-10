require 'spec_helper'
module EmailTracker
  describe Interceptor do 
    it "should be registered to deliver mail" do
      Interceptor.should_receive(:delivering_email)
      TestMailer.test.deliver
    end
    
    it "should call add_tracking" do
      Interceptor.should_receive(:add_tracking)
      TestMailer.test.deliver
    end
    
    it "should add tracking image" do
      TestMailer.test.deliver.body.should =~ /<img src="https:\/\/foobar.com\/et_open\/[a-zA-Z0-9]*.gif" alt=""\/>/
    end
    
    it "should not track no-track links" do
      TestMailer.test.deliver.body.should =~ /<a >A no-track link<\/a>/
    end
    
    it "should not track mailto links" do
      TestMailer.test.deliver.body.should =~ /<a href="mailto:jez.walker@gmail.com">A mail link<\/a>/
    end
    
    it "should track normal links" do      
      body = TestMailer.test.deliver.body
      instance = LinkInstance.where(is_externally_viewable: false).last
      body.should =~ /<a href="https:\/\/foobar.com\/et_click\/#{instance.url_code}">A normal link<\/a>/
    end
    
    it "should mark external links as such" do      
      body = TestMailer.test.deliver.body
      instance = LinkInstance.where(is_externally_viewable: true).last
      body.should =~ /<a href="https:\/\/foobar.com\/et_click\/#{instance.url_code}">An external link<\/a>/
    end
  end
end