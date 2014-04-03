require 'spec_helper'

describe Coordinate do
  let(:coordinate) { create(:coordinate) }

  it { expect(coordinate).to respond_to(:longitude) }
  it { expect(coordinate).to respond_to(:latitude) }
  it { expect(coordinate).to respond_to(:zipcode_id) }
  it { expect(coordinate).to belong_to(:zipcode) }
  it { expect(coordinate).to be_valid }

  describe "#longitude validation" do
    it "fails with nil value" do
      coordinate.longitude = nil
      expect(coordinate).to_not be_valid
    end
    it "fails with text" do
      coordinate.longitude = "ola k ace"
      expect(coordinate).to_not be_valid
    end
  end

  describe "#latitude validation" do
    it "fails with nil value" do
      coordinate.latitude = nil
      expect(coordinate).to_not be_valid
    end
    it "fails with text" do
      coordinate.latitude = "ola k ace"
      expect(coordinate).to_not be_valid
    end
  end

  describe "#zipcode validations" do
    it "fails with nil value" do
      coordinate.zipcode_id = nil
      expect(coordinate).to_not be_valid
    end
  end
end
