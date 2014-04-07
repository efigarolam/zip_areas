require "spec_helper"

describe Api::V1::ZipcodesController do
  let!(:zipcode1) { create(:zipcode) }
  let!(:zipcode2) { create(:zipcode) }
  let(:new_zipcode) { attributes_for(:zipcode) }

  describe "#index" do
    before { get :index }

    it { expect(response.status).to eq 200 }
    it { expect(response.content_type).to eq "application/json" }
    it "returns all of zipcodes" do
      zipcodes = JSON.parse(response.body, symbolize_names: true)
      expect(zipcodes.count).to eq Zipcode.count
    end
  end

  describe "#show" do
    context "the record exists" do
      before { get :show, id: zipcode1.id }

      it { expect(response.status).to eq 200 }
      it { expect(response.content_type).to eq "application/json" }
      it "returns zipcode1" do
        zipcode = JSON.parse(response.body, symbolize_names: true)
        expect(zipcode[:id]).to eq zipcode1.id
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
      before { post :create , zipcode: new_zipcode, format: :json }

      it { expect(Zipcode.count).to eq 3 }
      it { expect(response.content_type).to eq "application/json" }
      it { expect(response.body).to eq "" }
      it { expect(response.status).to eq 204 }
    end

    context "invalid data" do
      before do
        new_zipcode[:name] = ""
        post :create, zipcode: new_zipcode, format: :json
      end

      it { expect(Zipcode.count).to eq 2 }
      it { expect(response.content_type).to eq "application/json" }
      it { expect(response.status).to eq 422 }
      it "returns a json with the errors" do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:name]).to eq ["can't be blank"]
      end
    end
  end

  describe "#update" do
    context "valid data" do
      before { patch :update, id: zipcode1, zipcode: new_zipcode }

      it { expect(response.content_type).to eq "application/json" }
      it { expect(response.status).to eq 204 }
      it { expect(response.body).to eq "" }
    end

    context "invalid data" do
      before do
        new_zipcode[:name] = ""
        post :create, zipcode: new_zipcode, format: :json
      end

      it { expect(response.content_type).to eq "application/json" }
      it { expect(response.status).to eq 422 }
      it "returns a json with errors" do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:name]).to eq ["can't be blank"]
      end
    end
  end

  describe "#destroy" do
    context "record exits" do
      before { delete :destroy, id: zipcode1 }

      it { expect(Zipcode.count).to eq 1 }
      it { expect(response.content_type).to eq "application/json" }
      it { expect(response.status).to eq 204 }
      it { expect(response.body).to eq "" }
    end

    context "record doesn't exist" do
      before { delete :destroy, id: "xxx" }

      it { expect(response.content_type).to eq "application/json" }
      it { expect(response.status).to eq 404 }
      it "returns error message" do
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:error]).to eq "Sorry, but this record doesn't exist"
      end
    end
  end
end
