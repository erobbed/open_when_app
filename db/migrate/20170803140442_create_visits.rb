class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.integer :user_id
      t.timestamp :started_at
      t.timestamp :ended_at

      t.timestamps
    end
  end
end
