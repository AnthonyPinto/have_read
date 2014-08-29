class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, presence: true, index: true
      t.string :url
      t.text :content
      t.integer :sub_id, presence: true, index: true
      t.integer :author_id, presence: true, index: true

      t.timestamps
    end
  end
end
