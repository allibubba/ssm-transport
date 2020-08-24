require './lib/fetch.rb'
require 'json'

describe Fetch do
  let(:profile) { 'foo' }
  let(:mock_response) { JSON.parse(
    IO.read(File.join("spec", "fixtures", "parameters.json"))) }

  describe 'intialize' do
    it 'raises' do
      expect{Fetch.new()}.to raise_error(ArgumentError)
    end

    it 'validates' do
      expect{Fetch.new(profile)}.not_to raise_error
    end
  end

  describe 'returns data' do
    it 'retunrs an array' do
      fetch = Fetch.new(profile)
      allow(fetch).to receive(:aws_ssm_keys).and_return(mock_response)
      expect(fetch.parameters.count).to be(3)
    end
  end
end
