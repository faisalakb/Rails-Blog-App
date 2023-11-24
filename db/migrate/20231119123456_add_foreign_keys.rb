class AddForeignKeys < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :comments, :posts if foreign_key_exists?(:comments, :posts)
    remove_foreign_key :comments, :users if foreign_key_exists?(:comments, :users)
    remove_foreign_key :likes, :posts if foreign_key_exists?(:likes, :posts)
    remove_foreign_key :likes, :users if foreign_key_exists?(:likes, :users)
    remove_foreign_key :posts, :users, column: :author_id if foreign_key_exists?(:posts, :users)
    
    add_foreign_key :comments, :posts, on_delete: :cascade if table_exists?(:comments) && table_exists?(:posts)
    add_foreign_key :comments, :users, on_delete: :cascade if table_exists?(:comments) && table_exists?(:users)
    add_foreign_key :likes, :posts, on_delete: :cascade if table_exists?(:likes) && table_exists?(:posts)
    add_foreign_key :likes, :users, on_delete: :cascade if table_exists?(:likes) && table_exists?(:users)
    add_foreign_key :posts, :users, column: :author_id, on_delete: :cascade if table_exists?(:posts) && table_exists?(:users)
  end
end
