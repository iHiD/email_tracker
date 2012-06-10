class CreateEmailTrackerLinkInstances < ActiveRecord::Migration
  def change
    create_table :email_tracker_link_instances do |t|
      t.integer :link_id,     null: false
      t.integer :email_instance_id, null: false
      
      t.datetime :clicked_at, null: true
    end
    
    #add_foreign_key :email_tracking_link_instances, :email_tracking_links, column: :link_id
    #add_foreign_key :email_tracking_link_instances, :email_tracking_email_instances, column: :email_instance_id
  end
end
