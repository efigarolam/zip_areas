Given /^A user visit the root page$/ do
  visit root_path
end

Then /^A google map appears$/ do
  expect(page).to have_css("#zip-area-map-canvas")
end
