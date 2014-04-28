Feature: Viewing zipcodes in the page
  The user should be able to view the zipcode's name
  selected in the url

  Scenario: No selected zipcodes
    Given A user navigate to main page
    Then  Selected zipcodes area is empty

  @javascript
  Scenario: Selected zipcodes in url
    Given A user navigate to main page params 'zip_code 1234'
    Then  He should see the map with the given zipcode selected

