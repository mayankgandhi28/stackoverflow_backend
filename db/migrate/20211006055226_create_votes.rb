class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.boolean :is_up
      t.boolean :is_down
      t.belongs_to :user
      t.belongs_to :comment
      t.timestamps
    end
  end
end
