class AddAccessToBooks < ActiveRecord::Migration
  def change
    add_column :books, :access, :string
  end
end
