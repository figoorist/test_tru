class AddIndexToPostsAuthorIp < ActiveRecord::Migration[5.2]
  def change
  	add_index :posts, :author_ip
  end
end
