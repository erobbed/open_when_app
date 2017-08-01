class RenameReadOnPosts < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :read?, :read_status
  end
end
