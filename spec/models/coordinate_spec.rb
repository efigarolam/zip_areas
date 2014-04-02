require 'spec_helper'

describe Coordinate do
  let(:coordinate) { create(:coordinate) }

  it { expect(coordinate).to respond_to(:longitude) }
  it { expect(coordinate).to respond_to(:latitude) }
  it { expect(coordinate).to respond_to(:zipcode_id) }

end
