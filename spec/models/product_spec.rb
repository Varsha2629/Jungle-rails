require 'rails_helper'

RSpec.describe Product, type: :model do

  
  before(:each) do 
    @category = Category.new(name: 'Apparel')
  end

  describe 'Validations' do
     it "is valid with valid attributes" do
      @product = Product.new(name: 'Teddy', price: 19.00, quantity: 10, category: @category )
      @product.save!

      expect(@product).to be_present
    end

    it "is not valid without a name" do
      @product = Product.create(name: nil, description: 'Awesome Cats T-shirt', price: 35.00, quantity: 60, category: @category)
      
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "is not valid without a price" do
      @product = Product.create(name: "Pen", description: "Here is all black Pen", quantity: 20, category: @category)
     
      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it "is not valid without a quantity" do
      @product = Product.create(name: "Nails", description: 'Nice nails color', price: 15.00, quantity: nil, category: @category)

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "is not valid without a category" do
      @product = Product.create(name: "Botal", description: 'Water botal', price: 10.00, quantity: 90, category: nil)

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end