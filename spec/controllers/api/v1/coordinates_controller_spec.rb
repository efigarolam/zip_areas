require "spec_helper"

describe Api::V1::CoordinatesController do
  let!(:coordinate1) { create(:coordinate) }
  let!(:coordinate2) { create(:coordinate) }
  let(:new_coordinate) { attributes_for(:coordinate) }

  describe "#index" do
    before { get :index }

    it { expect(response.status).to eq 200 }
    it { expect(response.content_type).to eq "application/json" }
    it "returns all of zipcodes" do
      coordinates = JSON.parse(response.body, symbolize_names: true)
      expect(coordinates.count).to eq Coordinate.count
    end
  end

  describe "#show" do
    context "the record exists" do
      before { get :show, id: coordinate1 }

      it { expect(response.status).to eq 200 }
      it { expect(response.content_type).to eq "application/json" }
      it "returns coordinate1" do
        coordinate = JSON.parse(response.body, symbolize_names: true)
        expect(coordinate[:id]).to eq coordinate1.id
      end
    end

    context "record doesn't exist" do
      before { get :show, id: "xxx" }

      it { expect(response.content_type).to eq "application/json" }
      it { expect(response.status).to eq 404 }
      it "returns error message" do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:error]).to eq "Sorry, but this record doesn't exist"
      end
    end
  end

  describe "#create" do
    context "valid data" do
      before { post :create , coordinate: new_coordinate, format: :json }

      it { expect(Coordinate.count).to eq 3 }
      it { expect(response.content_type).to eq "application/json" }
      it { expect(response.body).to eq "" }
      it { expect(response.status).to eq 204 }
    end

    context "invalid data" do
      before do
        new_coordinate[:longitude] = ""
        post :create, coordinate: new_coordinate, format: :json
      end

      it { expect(Coordinate.count).to eq 2 }
      it { expect(response.content_type).to eq "application/json" }
      it { expect(response.status).to eq 422 }
      it "returns a json with the errors" do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:longitude]).to eq ["can't be blank", "is not a number"]
      end
    end
  end
end
