class TestMailer < ActionMailer::Base
  
  def test
    mail(to: "Jeremy Walker <jez.walker@gmail.com>", 
         subject: "My Subject",
         tracking_data: {some_data: true})
  end
  
end