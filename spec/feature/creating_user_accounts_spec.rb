

feature "Creating user account" do
  scenario "After filling out a completing signup form a user account is created" do
    visit "/signup"
    fill_in "email", with: "fake@email.com"
    fill_in "password", with: "password"
    click_button "submit"
    expect(page).to have_content "Welcome fake@email.com!"
  end
  scenario "Increases amount of users by 1" do
    expect{ User.create }.to change { User.count }.by(1)
  end
end
