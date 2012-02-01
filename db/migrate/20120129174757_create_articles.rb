class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.boolean :wg
      t.string :name

      t.timestamps
    end
  end
end
