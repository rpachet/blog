class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.date :publication_date
      t.string :header
      t.string :file

      t.integer :user_id

      t.timestamps
    end
  end
end
