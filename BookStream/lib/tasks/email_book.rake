desc 'email book'
task :email_book => :environment do
    BookMailer.send_book(ENV["USER"], ENV["BOOK"]).deliver
end