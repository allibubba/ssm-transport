# frozen_string_literal: true

require './lib/key_values'
require 'json'

describe KeyValues do
  let(:profile) { 'foo' }
  let(:mock_response) do
    JSON.parse(IO.read(File.join('spec', 'fixtures', 'parameters.json')))
  end
  let(:data) { mock_response['Parameters'] }
  let(:mock_reference_data) do
    JSON.parse(IO.read(File.join('spec', 'fixtures', 'values.json')))
  end
  let(:kv_instance) { described_class.new(profile, data) }

  describe 'intialize' do
    it 'raises' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end
    it 'validates' do
      expect { described_class.new(profile, data) }.not_to raise_error
    end
  end

  describe 'format_data' do
    context 'valid data' do
      it 'returns an array' do
        allow(kv_instance).to receive(:reference_data).and_return(mock_reference_data)
        expect(kv_instance.format_data.count).to be(2)
      end
    end
    context 'invalid data' do
      it 'exits' do
        allow(kv_instance).to receive(:reference_data).and_return('str')
        allow(kv_instance).to receive(:exit).and_return(true)
        expect(kv_instance.format_data).to be true
      end
    end
  end
end
