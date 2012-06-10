class CreateEmailTrackerLinks < ActiveRecord::Migration
  def change
    create_table :email_tracker_links do |t|
      t.string :url, null: false
      
      t.integer :num_clicks, null: false, default: 0
      
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
