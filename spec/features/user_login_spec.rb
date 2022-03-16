require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create!(first_name: 'Vish', last_name: 'Panchal', email: 'test@test.com', password: '123456', password_confirmation: '123456')
  end

  scenario "They go to the product page" do
    visit login_path


    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: '123456'
    click_on 'Submit'

    save_screenshot
    expect(page).to have_text('Logout')

  end
 
end
