require 'spec_helper'

describe Coordinate do
  let(:coordinate) { create(:coordinate) }

  it { expect(coordinate).to respond_to(:longitude) }
  it { expect(coordinate).to respond_to(:latitude) }
  it { expect(coordinate).to respond_to(:zipcode_id) }
  it { expect(coordinate).to belong_to(:zipcode) }
  it { expect(coordinate).to be_valid }

  describe "longitude validations fails" do
    it "is nil" do
      coordinate.longitude = nil
      expect(coordinate).to_not be_valid
    end
    it "is too long" do
      coordinate.longitude = "1" * 11
      expect(coordinate).to_not be_valid
    end
    it "is too short" do
      coordinate.longitude = "1" * 7
      expect(coordinate).to_not be_valid
    end
    it "isn't a number" do
      coordinate.longitude = "ola k ace"
      expect(coordinate).to_not be_valid
    end
  end

  describe "latitude validations fails" do
    it "is nil" do
      coordinate.latitude = nil
      expect(coordinate).to_not be_valid
    end
    it "is too long" do
      coordinate.latitude = "1" * 11
      expect(coordinate).to_not be_valid
    end
    it "is too short" do
      coordinate.latitude = "1" * 7
      expect(coordinate).to_not be_valid
    end
    it "isn't a number" do
      coordinate.latitude = "ola k ace"
      expect(coordinate).to_not be_valid
    end
  end

  describe "zipcode_id validations fails" do
    it "is nil" do
      coordinate.zipcode_id = nil
      expect(coordinate).to_not be_valid
    end
  end
end
