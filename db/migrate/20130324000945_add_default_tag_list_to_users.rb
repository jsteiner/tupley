class AddDefaultTagListToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_tag_list, :string, null: false, default: ''
  end
end
