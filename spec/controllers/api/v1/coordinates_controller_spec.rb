require "spec_helper"
require "support/shared_examples"

describe Api::V1::CoordinatesController do
  let!(:coordinate1) { create(:coordinate) }
  let!(:coordinate2) { create(:coordinate) }
  let(:new_coordinate) { attributes_for(:coordinate) }

  describe "#index" do
    let(:http_code) { 200 }
    let(:response_body) { Coordinate.all.to_json }

    before { get :index }

    it_should_behave_like "response"
  end

  describe "#show" do
    context "the record exists" do
      let(:http_code) { 200 }
      let(:response_body) { coordinate1.to_json }

      before { get :show, id: coordinate1 }

      it_should_behave_like "response"
    end

    context "record doesn't exist" do
      let(:http_code) { 404 }
      let(:response_body) do
        { error: "Sorry, but this record doesn't exist" }.to_json
      end

      before { get :show, id: "xxx" }

      it_should_behave_like "response"
    end
  end

  describe "#create" do
    context "valid data" do
      let(:http_code) { 204 }
      let(:response_body) { "" }

      before { post :create , coordinate: new_coordinate, format: :json }

      it_should_behave_like "response"
      it { expect(Coordinate.count).to eq 3 }
    end

    context "invalid data" do
      let(:http_code) { 422 }
      let(:response_body) do
        { longitude: ["can't be blank", "is not a number"] }.to_json
      end

      before do
        new_coordinate[:longitude] = ""
        post :create, coordinate: new_coordinate, format: :json
      end

      it_should_behave_like "response"
      it { expect(Coordinate.count).to eq 2 }
    end
  end

  describe "#update" do
    context "valid data" do
      let(:http_code) { 204 }
      let(:response_body) { "" }

      before { patch :update, id: coordinate1, coordinate: new_coordinate }

      it_should_behave_like "response"
    end

    context "invalid data" do
      let(:http_code) { 422 }
      let(:response_body) do
        { longitude: ["can't be blank", "is not a number"] }.to_json
      end

      before do
        new_coordinate[:longitude] = ""
        post :create, coordinate: new_coordinate, format: :json
      end

      it_should_behave_like "response"
    end
  end

  describe "#destroy" do
    context "record exits" do
      let(:http_code) { 204 }
      let(:response_body) { "" }

      before { delete :destroy, id: coordinate1 }

      it_should_behave_like "response"
      it { expect(Coordinate.count).to eq 1 }
    end

    context "record doesn't exist" do
      let(:http_code) { 404 }
      let(:response_body) do
        { error: "Sorry, but this record doesn't exist" }.to_json
      end

      before { delete :destroy, id: "xxx" }

      it_should_behave_like "response"
    end
  end
end

