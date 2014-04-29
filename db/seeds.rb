zipcodes = YAML.load_file('config/ny_zip_areas.yml')

zipcodes.each do |zipcode|
  Zipcode.create!(name: zipcode['name'])
  zipcode['boundaries'].each do |coordinate|
    Coordinate.create!(longitude: coordinate['longitude'].to_f,
                       latitude: coordinate['latitude'].to_f,
                       zipcode: Zipcode.last)
  end
end
