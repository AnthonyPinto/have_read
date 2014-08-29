class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false, uniqueness: true
      t.string :description, null: false
      t.integer :moderator_id, null: false

      t.timestamps
    end
    add_index :subs, :moderator_id
  end
end
