class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commenter_id, presence: true, index: true
      t.integer :post_id, presence: true, index: true
      t.text :content, presence: true

      t.timestamps
    end
  end
end
