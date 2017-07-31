class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :passowrd_digest

      t.timestamps
    end
  end
end
