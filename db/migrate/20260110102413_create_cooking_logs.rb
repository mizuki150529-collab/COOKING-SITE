class CreateCookingLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :cooking_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.date :cooked_on

      t.timestamps
    end
  end
end
