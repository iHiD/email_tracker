
module EmailTracker
  
=begin
  class TitleModel < ActiveRecord::Base
    self.table_name = :email_tracker_emails
    def title
      "My Title"
    end
  end
  
  class NameModel < ActiveRecord::Base
    self.table_name = :email_tracker_emails
    def name
      "My Name"
    end
  end
=end
  
  describe Email do 
    it "should set name correctly" do
      
      Email.create!({mailer: "My/Mailer", action: "my_action"}, as: :email_tracker_internals).name.should == "Mailer My action"
      
      owner = mock_model(Subscription)
      owner.should_receive(:title).and_return("My Title")
      Email.create!({mailer: "my_mailer", action: "my_action", owner: owner}, as: :email_tracker_internals).name.should == "My Title"
      
      owner = mock_model(Subscription)
      owner.should_receive(:name).and_return("My Name")
      Email.create!({mailer: "my_mailer", action: "my_action", owner: owner}, as: :email_tracker_internals).name.should == "My Name"
      
      owner = mock_model(Subscription)
      Email.create!({mailer: "my_mailer", action: "my_action", owner: owner}, as: :email_tracker_internals).name.should == "Subscription ##{owner.id}"
    end
  end
end