require 'rails_helper'

RSpec.describe User, type: :model do
   it 'should be a valid user' do
      user = User.create(name:'ignacio', last_name:'test',
                         email:'ignaciomarquezc@gmail.com',
                         password: '123456', password_confirmation: '123456')
      expect(user).to be_valid
   end

   it 'should fail creation if password_confirmation does not match' do
      user = User.create(name:'ignacio', last_name:'test',
                         email:'ignaciomarquezc@gmail.com',
                         password: '123456', password_confirmation: '654321')
      expect(user).not_to be_valid       
   end 
end
