class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.text :content, null: false
      t.integer :parent_comment_id

      t.timestamps null: false
    end

    add_index :comments, :user_id
    add_foreign_key :comments, :users

    add_index :comments, :post_id
    add_foreign_key :comments, :posts

    add_index :comments, :parent_comment_id
    add_foreign_key :comments, :comments
  end
end
