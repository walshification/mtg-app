require 'feature_helper'

feature "Card Search", js: true do
  let(:email) { "bob@example.com" }
  let(:password) { "password123" }

  before do
    User.create!(
      email: email,
      password: password,
      password_confirmation: password
    )
    (102..114).each do |id|
      Card.create!(
        multiverse_id: id,
        name: "Counterspell",
        image_url:
          "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{id}&type=card",
      )
    end
    Card.create!(
      multiverse_id: 197,
      name: "Fireball",
      image_url:
        "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=197&type=card",
    )

    visit "/cards"
    # Log in
    fill_in "Email", with: "bob@example.com"
    fill_in "Password", with: "password123"
    click_button "Sign in"
    # Check that we go to the right page
    expect(page).to have_content("Card Search")
  end

  it "returns cards from the database that match the keyword name" do
    fill_in "keywords", with: "Counterspell"
    within("section.search-results") do
      expect(page).to have_selector(:css, "img#Counterspell-102")
    end
  end

  it "doesn't return cards that don't match the keyword name" do
    fill_in "keywords", with: "Fireball"
    within("section.search-results") do
      expect(page).to_not have_selector(:css, "img#Counterspell-102")
    end
  end

  it "only displays twelve results at a time" do
    fill_in "keywords", with: "Counterspell"
    within("section.search-results") do
      expect(page.all("img.gallery_card").count).to eq(12)
    end
  end

  it "paginates results that contain more than twelve cards" do
    fill_in "keywords", with: "Counterspell"
    within("section.search-results") do
      expect(page).to have_selector(:css, "img#Counterspell-102")
    end
    within(:css, "#top-pager") do
      click_on("Next →")
    end
    within("section.search-results") do
      expect(page).to_not have_selector(:css, "img#Counterspell-102")
      expect(page).to have_selector(:css, "img#Counterspell-114")
      expect(page.all("img.gallery_card").count).to eq(1)
    end
  end
end
