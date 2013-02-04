require 'spec_helper'
require 'benchmark'

module EmailTracker
  describe Interceptor do 
    it "should be registered to deliver mail" do
      Interceptor.should_receive(:delivering_email)
      TestMailer.test.deliver
    end
    
    it "should call add_tracking" do
      Interceptor.should_receive(:new)
      TestMailer.test.deliver
    end
    
    it "should set mailer, action and extras in tracking_data" do
      TestMailer.test.tracking_data.should == {
        mailer: "test_mailer",
        action: "test",
        subject: "My Subject",
        some_data: true
      }
    end
    
    it "should create an email" do
      EmailTracker::Email.destroy_all
      TestMailer.test.deliver
      
      EmailTracker::Email.count.should == 1
      email = EmailTracker::Email.first
      
      email.mailer.should == "test_mailer"
      email.action.should == "test"
      email.subject.should == "My Subject"
    end
  
    it "should find an existing email" do
      EmailTracker::Email.destroy_all
      
      TestMailer.test.deliver
      EmailTracker::Email.count.should == 1
      email = EmailTracker::Email.last
      email.times_sent.should == 1
      
      TestMailer.test.deliver
      EmailTracker::Email.count.should == 1
      email.reload
      email.times_sent.should == 2
    end
    
    it "should add tracking image" do
      EmailTracker::Email.destroy_all
      
      body = TestMailer.test.deliver.body
      email = EmailTracker::Email.first
      hashed_email = Base64.encode64("jez.walker@gmail.com").strip
      TestMailer.test.deliver.body.should include %Q{<img src="https://foobar.com/et/#{email.id}/#{hashed_email}.gif" alt=""/>}
    end
    
    it "should not track mailto links" do
      TestMailer.test.deliver.body.should include %Q{<a href="mailto:jez.walker@gmail.com">A mail link</a>}
    end
    
    it "should track normal links" do
      EmailTracker::Email.destroy_all  
      
      body = TestMailer.test.deliver.body
      email = EmailTracker::Email.first
      hashed_email = Base64.encode64("jez.walker@gmail.com").strip
      body.should include %Q{a href="https://foobar.com/foobar?et=#{email.id}_#{hashed_email}">A normal link</a>}
    end
    
    it "should be fast" do
      Benchmark.measure do |b|
        80.times { TestMailer.test.deliver }
      end.real.should be < 1
    end
  end
end