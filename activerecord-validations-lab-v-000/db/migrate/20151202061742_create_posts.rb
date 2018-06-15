class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.text :summary
      t.string :category

      t.timestamps null: false
    end
  end
end
