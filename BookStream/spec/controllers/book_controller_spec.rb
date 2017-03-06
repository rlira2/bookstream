require 'rails_helper'

"""RSpec.describe BooksController, type: :controller do
  describe 'GET #show' do

    libro = Book.create(name:'HARRY POTTER', author:'JK ROWLING', document: File.read('/Users/iMarquezc/Desktop/Libros/HarryPotter.pdf'))


    it 'load ok' do
      get :show/1
      current_user = User.create(name:'ignacio', last_name:'test',
                                 email:'ignaciomarquezc@gmail.com',
                                 password: '123456', password_confirmation: '123456')
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'redirects user to /home if it is not his book' do
      get :show/1
      current_user = User.create(name:'ignacio', last_name:'test',
                                 email:'ignaciomarquezc@gmail.com',
                                 password: '123456', password_confirmation: '123456')
      expect(response).to render_template('pages#home')
    end

  end

end"""
