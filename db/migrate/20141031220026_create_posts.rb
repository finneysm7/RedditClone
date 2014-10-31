class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content
      t.references :sub, index: true, null: false
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
