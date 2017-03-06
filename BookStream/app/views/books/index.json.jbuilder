json.array!(@books) do |book|
  json.extract! book, :id, :name, :author, :file
  json.url book_url(book, format: :json)
end
