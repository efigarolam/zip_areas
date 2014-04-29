require 'spec_helper'
require 'support/shared_examples'

describe Api::V1::ZipcodesController do
  let!(:zipcode1) { create(:zipcode) }
  let!(:zipcode2) { create(:zipcode) }

  describe '#index' do
    let(:http_code) { 200 }
    let(:response_body) { Zipcode.all.to_json(include: :coordinates) }

    before { get :index }

    it_should_behave_like 'correct response'
  end

  describe '#show' do
    context 'when the record exists' do
      let(:http_code) { 200 }
      let(:response_body) { zipcode1.to_json(include: :coordinates) }

      before { get :show, id: zipcode1.id }

      it_should_behave_like 'correct response'
    end

    context "when the record doesn't exist" do
      let(:http_code) { 404 }
      let(:response_body) do
        { error: "Sorry, but this record doesn't exist" }.to_json
      end

      before { get :show, id: 'xxx' }

      it_should_behave_like 'correct response'
    end
  end
end

