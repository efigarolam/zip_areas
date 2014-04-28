Given /^A user navigate to main page$/ do
  visit root_path
end

Then /^Selected zipcodes area is empty$/ do
  expect(page.find('#selected-zip-codes').text).to eq ''
end

Given /^A user navigate to main page params 'zip_code 1234'$/ do
  visit root_path(zip_codes: 1234)
end

Then /^He should see the map with the given zipcode selected$/ do
  expect(page.find('#selected-zip-codes').text).to eq '1234'
end

