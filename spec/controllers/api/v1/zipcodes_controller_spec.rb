require "spec_helper"
require "support/shared_examples"

describe Api::V1::ZipcodesController do
  let!(:zipcode1) { create(:zipcode) }
  let!(:zipcode2) { create(:zipcode) }
  let(:new_zipcode) { attributes_for(:zipcode) }

  describe "#index" do
    let(:http_code) { 200 }
    let(:response_body) { Zipcode.all.to_json }

    before { get :index }

    it_should_behave_like "response"
  end

  describe "#show" do
    context "the record exists" do
      let(:http_code) { 200 }
      let(:response_body) { zipcode1.to_json }

      before { get :show, id: zipcode1.id }

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

      before { post :create , zipcode: new_zipcode, format: :json }

      it_should_behave_like "response"
      it { expect(Zipcode.count).to eq 3 }
    end

    context "invalid data" do
      let(:http_code) { 422 }
      let(:response_body) { { name: ["can't be blank"] }.to_json }

      before do
        new_zipcode[:name] = ""
        post :create, zipcode: new_zipcode, format: :json
      end

      it_should_behave_like "response"
      it { expect(Zipcode.count).to eq 2 }
    end
  end

  describe "#update" do
    context "valid data" do
      let(:http_code) { 204 }
      let(:response_body) { "" }

      before { patch :update, id: zipcode1, zipcode: new_zipcode }

      it_should_behave_like "response"
    end

    context "invalid data" do
      let(:http_code) { 422 }
      let(:response_body) { { name: ["can't be blank"] }.to_json }

      before do
        new_zipcode[:name] = ""
        post :create, zipcode: new_zipcode, format: :json
      end

      it_should_behave_like "response"
    end
  end

  describe "#destroy" do
    context "record exits" do
      let(:http_code) { 204 }
      let(:response_body) { "" }

      before { delete :destroy, id: zipcode1 }

      it_should_behave_like "response"
      it { expect(Zipcode.count).to eq 1 }
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

