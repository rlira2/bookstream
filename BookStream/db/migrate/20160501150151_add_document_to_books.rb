class AddDocumentToBooks < ActiveRecord::Migration
  def up
    add_attachment :books, :document
  end

  def down
    remove_attachment :books, :document
  end
end