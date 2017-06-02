require_relative 'web_helpers'

feature "Tagging Links" do
  scenario "Add a single tag to a link" do
    add_new_link
    fill_in 'tags', with: 'educational'
    click_button 'submit'
    link = Link.first
    expect(link.tags.map(&:name)).to include('educational')
  end
  scenario "Adding multiple tags to a link" do
    add_new_link
    fill_in 'tags', with: 'educational, fun'
    click_button 'submit'
    link = Link.all(:id => 2)
    expect(link.tags.map(&:name)).to include('fun')
  end
end
