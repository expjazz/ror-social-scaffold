class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :active_id
      t.integer :passive_id
      t.boolean :status

      t.timestamps
    end
    add_index :friendships, :active_id
    add_index :friendships, :passive_id
    add_index :friendships, %i[active_id passive_id], unique: true

  end
end
