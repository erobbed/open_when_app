class CreateOpens < ActiveRecord::Migration[5.1]
  def change
    create_table :opens do |t|
      t.integer :recipient_id
      t.boolean :read?, default: false
      t.datetime :read_time
      t.integer :post_id
      t.timestamps
    end
  end
end
