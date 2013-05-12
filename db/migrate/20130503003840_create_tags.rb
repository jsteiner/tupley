class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.boolean :default, null: false, default: false
      t.references :user
      t.timestamps
    end

    add_index :tags, :slug
    add_index :tags, :user_id

    create_table :taggings do |t|
      t.references :tag
      t.references :task
      t.timestamps
    end

    add_index :taggings, [:tag_id, :task_id], unique: true
  end
end
