class CreateEmailTrackerEmailInstances < ActiveRecord::Migration
  def change
    create_table :email_tracker_email_instances do |t|
      
      t.integer :email_id, null:false
      
      t.string  :email_address, null: false
      t.string  :url_code,      null: false
      t.integer :user_id,       null: true
      
      t.datetime :created_at, null:false
      t.datetime :updated_at, null:false
      t.datetime :opened_at, null:true
    end
    
    #add_foreign_key :email_tracking_email_instances, :email_tracking_emails, column: :email_id
    #add_foreign_key :email_tracking_email_instances, :users,                 column: :user_id
  end
end
