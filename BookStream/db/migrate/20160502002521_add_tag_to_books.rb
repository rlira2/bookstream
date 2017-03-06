class AddTagToBooks < ActiveRecord::Migration
  def change
    add_column :books, :tag, :has_and_belongs_to_many
  end
end
