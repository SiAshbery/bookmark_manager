

feature "Creating user account" do
  scenario "After filling out a completing signup form a user account is created" do
    expect{ signup}.to change(User, :count )
  end

  scenario "Confirm password must match password" do
    expect{ signup(password_confirmation: "notpassword")}.not_to change(User, :count )
  end

  def signup(email: "fake@email.com",
            password:"password",
            password_confirmation: "password")
    visit "/signup"
    fill_in "email", with: email
    fill_in "password", with: password
    fill_in "password_confirmation", with: password_confirmation
    click_button "submit"
  end
end
