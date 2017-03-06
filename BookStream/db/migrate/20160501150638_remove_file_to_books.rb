class RemoveFileToBooks < ActiveRecord::Migration
  def change
    remove_column :books, :file, :string
  end
end
