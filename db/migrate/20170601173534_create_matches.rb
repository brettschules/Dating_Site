class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.integer :likes_id
      t.integer :liked_id

      t.timestamps
    end
    add_index :matches, :likes_id
    add_index :matches, :liked_id
    add_index :matches, [:likes_id, :liked_id], unique: true
  end
end
