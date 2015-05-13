require 'capybara/rspec'
#require 'battleships'

feature 'Home Page' do
  # include Capybara::DSL
  # Capybara.app = App
  scenario 'Expect page to have content Welcome to battleship' do
    visit '/'
    expect(page).to have_content('Welcome to battleships!!!!')
  end
end