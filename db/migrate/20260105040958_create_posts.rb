class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :ingredients
      t.text :steps
      t.integer :cook_time
      t.integer :dish_type
      t.integer :difficulty
      t.string :cuisine_type
      t.integer :user_id

      t.timestamps
    end
  end
end
