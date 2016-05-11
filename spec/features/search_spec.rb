require 'rails_helper'

feature "Card Search", js: true do
  let(:email) { "bob@example.com" }
  let(:password) { "password123" }

  before do
    User.create!(
      email: email,
      password: password,
      password_confirmation: password
    )
    Card.create!(
      multiverse_id: 102,
      name: "Counterspell",
      image_url: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=102&type=card",
    )
  end

  scenario "search form returns cards from the database" do
    visit "/cards"

    # Log In
    fill_in "Email", with: "bob@example.com"
    fill_in "Password", with: "password123"
    click_button "Sign in"

    # Check that we go to the right page
    expect(page).to have_content("Card Search")

    # Test the page
    fill_in "keywords", with: "Counterspell"
    expect(page).to have_selector(:css, "img#Counterspell-102")
  end
end
