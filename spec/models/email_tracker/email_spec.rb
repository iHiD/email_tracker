require 'spec_helper'
module EmailTracker
  describe Email do 
    it "should increment times_sent when sent" do
      email = FactoryGirl.create(:email)
      lambda{ 
        email.sent!
      }.should change(email, :times_sent).by(1)
    end
    
    it "should correctly calculate times opened" do
      email = FactoryGirl.create(:email)
      email_address_hash = EmailTracker.hash_email_address("jez.walker@gmail.com")
      
      lambda{ 
        email.opens.create!({email_address_hash: email_address_hash}, as: :email_tracker_internals)
      }.should change(email, :times_opened).by(1)
    end
    
    it "should correctly calculate times opened from a date" do
      email = FactoryGirl.create(:email)
      email_address_hash = EmailTracker.hash_email_address("jez.walker@gmail.com")
      
      email.opens.create!({email_address_hash: email_address_hash}, as: :email_tracker_internals)
      email.opens.create!({email_address_hash: email_address_hash}, as: :email_tracker_internals)
      email.opens.create!({email_address_hash: email_address_hash}, as: :email_tracker_internals)
      open = email.opens.create!({email_address_hash: email_address_hash}, as: :email_tracker_internals)
      email.times_opened.should == 4
      
      open.created_at = DateTime.now - 1.year
      open.save!
      email.times_opened(DateTime.now - 6.months).should == 3
    end
    
    it "should correctly calculate times opened from a date" do
      email = FactoryGirl.create(:email)
      email.update_attribute(:times_sent, 21)
      email_address_hash = EmailTracker.hash_email_address("jez.walker@gmail.com")
      
      email.opens.create!({email_address_hash: email_address_hash}, as: :email_tracker_internals)
      email.opens.create!({email_address_hash: email_address_hash}, as: :email_tracker_internals)
      email.opens.create!({email_address_hash: email_address_hash}, as: :email_tracker_internals)
      open = email.opens.create!({email_address_hash: email_address_hash}, as: :email_tracker_internals)
      email.opened_percentage.should == 19
      
      open.created_at = DateTime.now - 1.year
      open.save!
      email.opened_percentage(DateTime.now - 6.months).should == 14
    end 
    
    it "should correctly calculate times clicked" do
      email = FactoryGirl.create(:email)
      email_address_hash = EmailTracker.hash_email_address("jez.walker@gmail.com")
      
      lambda{ 
        email.clicks.create!({email_address_hash: email_address_hash, url: "/foobar"}, as: :email_tracker_internals)
      }.should change(email, :num_links_clicked).by(1)
    end
    
    it "should correctly calculate times clicked from a date" do
      email = FactoryGirl.create(:email)
      email_address_hash = EmailTracker.hash_email_address("jez.walker@gmail.com")
      
      email.clicks.create!({email_address_hash: email_address_hash, url: "/foobar"}, as: :email_tracker_internals)
      email.clicks.create!({email_address_hash: email_address_hash, url: "/foobar"}, as: :email_tracker_internals)
      email.clicks.create!({email_address_hash: email_address_hash, url: "/foobar"}, as: :email_tracker_internals)
      click = email.clicks.create!({email_address_hash: email_address_hash, url: "/foobar"}, as: :email_tracker_internals)
      email.num_links_clicked.should == 4
      
      click.created_at = DateTime.now - 1.year
      click.save!
      email.num_links_clicked(DateTime.now - 6.months).should == 3
    end
  end
end