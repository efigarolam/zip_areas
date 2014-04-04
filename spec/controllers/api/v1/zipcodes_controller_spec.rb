require "spec_helper"

describe Api::V1::ZipcodesController do
  let!(:zipcode1) { create(:zipcode) }
  let!(:zipcode2) { create(:zipcode) }
  let(:zipcode) { attributes_for(:zipcode) }

  describe "#index" do
    before { get :index }

    it "returns 200 code status" do
      expect(response.status).to eq 200
    end
    it "returns all of zipcodes" do
      zipcodes = JSON.parse(response.body, symbolize_names: true)
      expect(zipcodes.count).to eq Zipcode.count
    end
    it "returns a JSON" do
      expect(response.content_type).to eq "application/json"
    end
    it "goes to #index action" do
      expect(get: api_v1_zipcodes_path).to route_to(
        controller: "api/v1/zipcodes", action: "index", format: "json")
    end
  end
end
