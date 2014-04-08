require 'spec_helper'
require 'support/shared_examples'

describe Api::V1::CoordinatesController do
  let!(:coordinate1) { create(:coordinate) }
  let!(:coordinate2) { create(:coordinate) }
  let(:new_coordinate) { attributes_for(:coordinate) }

  describe '#index' do
    let(:http_code) { 200 }
    let(:response_body) { Coordinate.all.to_json }

    before { get :index }

    it_should_behave_like 'response'
  end

  describe '#show' do
    context 'when the record exists' do
      let(:http_code) { 200 }
      let(:response_body) { coordinate1.to_json }

      before { get :show, id: coordinate1 }

      it_should_behave_like 'response'
    end

    context "when the record doesn't exist" do
      let(:http_code) { 404 }
      let(:response_body) do
        { error: "Sorry, but this record doesn't exist" }.to_json
      end

      before { get :show, id: 'xxx' }

      it_should_behave_like 'response'
    end
  end
end

