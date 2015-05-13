# require 'capybara/rspec'
#require 'battleships'

feature 'Home Page' do
  scenario 'Expect page to have content Welcome to battleship' do
    visit '/'
    expect(page).to have_content('Welcome')
  end
end