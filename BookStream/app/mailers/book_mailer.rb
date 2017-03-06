class BookMailer < ApplicationMailer
  default from: "bookstreammailer@gmail.com"

  def send_book(user, book)
    @user = User.find(user)
    @book = Book.find(book)
    attachments[@book.document_file_name] = File.read((Rails.root.to_s + "/public" + @book.document.url).split('?').first)
    mail to: @user.email, subject: "Hey here is your book " + @book.name + "!"
  end
end
