class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.integer :category_id
      t.integer :sender_id
      t.integer :recipient_id, null: true
      t.string :recipient_email
      t.boolean :read?, default: false
      t.datetime :read_time

      t.timestamps
    end
  end
end

# class CreateOpens < ActiveRecord::Migration[5.1]
#   def change
#     create_table :opens do |t|
#       t.integer :recipient_id
#       t.boolean :read_status, default: false
#       t.datetime :read_time
#       t.integer :post_id
#       t.timestamps
#     end
#   end
# end
#
