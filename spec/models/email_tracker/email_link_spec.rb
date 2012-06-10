module EmailTracker
  describe Link do
    
    it "should call find_or_create_by_url when calling for_url" do
      EmailTracker::Link.should_receive(:find_or_create_by_url)
      EmailTracker::Link.for_url("foobar")
    end
  end
end
