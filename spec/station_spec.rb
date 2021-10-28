require 'station'

describe Station do
  let(:station_victoria) {Station.new("Victoria", 1)}
  it "contains a zone on initialization" do
    expect(station_victoria).to respond_to(:zone)
  end
  it "contains a name on initialization" do
    expect(station_victoria).to respond_to(:name)
  end
end