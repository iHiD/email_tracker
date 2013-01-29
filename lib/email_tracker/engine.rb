module EmailTracker
  class Engine < ::Rails::Engine
    isolate_namespace EmailTracker
    initializer  "emailtracker.load_helpers" do
      ActiveSupport.on_load(:action_controller) do
        include EmailTracker::Helpers
      end
    end
  end
end
