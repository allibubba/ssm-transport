# frozen_string_literal: true

require './lib/fetch'
require 'json'

describe Fetch do
  let(:profile) { 'foo' }
  let(:mock_response) do
    JSON.parse(IO.read(File.join('spec', 'fixtures', 'parameters.json')))
  end

  describe 'intialize' do
    it 'raises' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it 'validates' do
      expect { described_class.new(profile) }.not_to raise_error
    end
  end

  describe 'parameters' do
    it 'returns an array' do
      fetch = Fetch.new(profile)
      allow(fetch).to receive(:aws_ssm_keys).and_return(mock_response)
      expect(fetch.parameters.count).to be(3)
    end
  end
end
