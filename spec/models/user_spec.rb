require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

     it "create a new user if all field are valid" do
      @user = User.new(first_name: 'Vish', last_name: 'Panchal', email: 'test@test.COM', password: 'password', password_confirmation: 'password')
      @user.save
      expect(@user).to be_present
    end

    it "does not creat a new user if first_name is missing" do
      @user = User.create(first_name: nil, last_name: 'Panchal', email: 'test@test.COM', password: 'password', password_confirmation: 'password')
    
      expect(@user.errors.full_messages).to include("First name can't be blank")     
    end

    it "does not creat a new user if last_name is missing" do
      @user = User.create(first_name: 'Varsha', last_name: nil, email: 'test@test.COM', password: 'password', password_confirmation: 'password')
    
      expect(@user.errors.full_messages).to include("Last name can't be blank")     
    end
    
    it "email is not valid if it is exists" do
      @user = User.create(first_name: 'Varsha', last_name: 'Panchal', email: 'test@test.COM', password: 'password', password_confirmation: 'password')
      @user = User.create(first_name: 'Varsha', last_name: 'Panchal', email: 'test@test.COM', password: 'password', password_confirmation: 'password')

      expect(@user.errors.full_messages).to include("Email has already been taken") 
    end

    it "Email is not valid if it is empty" do
      @user = User.create(first_name: "Varsha", last_name: 'Panchal', password: 'password', password_confirmation: 'password')

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "Password is not valid if it empty" do 
      @user = User.create(first_name: 'Varsha', last_name: 'Panchal', email: 'test@test.COM', password_confirmation: 'password') 

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "Password confirmation not valid if it empty" do 
      @user = User.create(first_name: 'Varsha', last_name: 'Panchal', email: 'test@test.COM', password: 'password')

      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "Password and Password confirmation must be same" do 
      @user = User.create(first_name: 'Varsha', last_name: 'Panchal', email: 'test@test.COM', password: 'password', password_confirmation: 'pass')     

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "Password is not valid if it has less than 6 characters" do 

      @user = User.create(first_name: 'Varsha', last_name: 'Panchal', email: 'test@test.COM', password: 'pass', password_confirmation: 'pass')     
      
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  
  describe '.authenticate_with_credentials' do

    before do
      @user =  User.new(first_name: 'Varsha', last_name: 'Panchal', email: 'test@test.COM', password: 'password', password_confirmation: 'password') 
    end

    it "login should be success if it has right credentials" do     
      expect(User.authenticate_with_credentials('@user.email', '@user.password')).to be(@user.id)
    end

    it "login should not be success if it has not email" do     
      expect(User.authenticate_with_credentials(nil, 'password')).to be_nil
    end

    it "login should not be success if it has not password" do     
      expect(User.authenticate_with_credentials('test@test.COM', nil)).to be_nil
    end
    it "login should not be success if email has whitespace" do     
      expect(User.authenticate_with_credentials(' test@test.COM', 'password')).to be(@user.id)
    end

    it "login should be success if email has casesensitive" do     
      expect(User.authenticate_with_credentials(' Test@Test.COM', 'password')).to be(@user.id)
    end

  end
end