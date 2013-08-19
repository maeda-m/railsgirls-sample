class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :idea
      t.text :comment

      t.timestamps
    end
    add_index :likes, :idea_id
  end
end
