class AddUserRelationInPost < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :user_id
    add_reference :posts, :user, index: true
  end
end
