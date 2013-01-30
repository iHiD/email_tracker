class CreateEmailTrackerLinkClicks < ActiveRecord::Migration
  def change
    create_table :email_tracker_link_clicks do |t|
      
      t.integer :email_id, null:false
      t.string :email_address, null:false
      t.string :url, null: false
      
      t.integer :user_id, null:true
      t.datetime :created_at, null:false
      
    end
    #add_foreign_key :email_tracker_email_instances, :email_tracker_emails, column: :email_id
  end
end
