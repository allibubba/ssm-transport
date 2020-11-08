# frozen_string_literal: true

require './lib/core'
require 'json'

describe Core do
  let(:profile) { 'foo' }
  let(:mock_push_payload) { true }
  let(:source) { [] }

  describe 'intialize' do
    it 'raises' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it 'validates' do
      expect { described_class.new(profile, profile, :source) }.not_to raise_error
    end
  end

  describe 'perform' do
    it 'returns true' do
      core = Core.new(profile, profile, source)
      allow(core).to receive(:push_payload).and_return(mock_push_payload)
      allow($stdin).to receive(:gets).and_return('y')
      expect(core.perform).to eq true
    end
  end
end
