Given /^A user navigate to main page$/ do
  visit root_path
end

Then /^Selected zipcodes area is empty$/ do
  expect(page.find('#selected-zip-codes').text).to eq ''
end

Given /^A user navigate to main page with params$/ do
  visit root_path(zip_codes: 1234)
end

Then /^Should appear the selected zipcodes$/ do
  expect(page.find('#selected-zip-codes').text).to eq '1234'
end

