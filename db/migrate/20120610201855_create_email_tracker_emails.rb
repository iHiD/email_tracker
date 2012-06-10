class CreateEmailTrackerEmails < ActiveRecord::Migration
  def change
    create_table :email_tracker_emails do |t|

      t.string :name,        null:true
      t.text   :description, null:true
      
      t.string :mailer, null: false
      t.string :action, null: false
      
      t.string  :owner_type, null: true
      t.integer :owner_id, null: true
      
      t.datetime :created_at, null:false
      t.datetime :updated_at, null:false
    end
  end
end
