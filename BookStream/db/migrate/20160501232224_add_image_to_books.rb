class AddImageToBooks < ActiveRecord::Migration
  def up
    add_attachment :books, :image
  end

  def down
    remove_attachment :books, :image
  end
end