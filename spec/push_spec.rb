# frozen_string_literal: true

require './lib/push'
require 'json'

describe Push do
  let(:profile) { 'foo' }
  let(:mock_response) { JSON.parse(IO.read(File.join('spec', 'fixtures', 'parameters.json'))) }
  let(:ssm_param) { '/prod/foo/bar/baz' }
  let(:ssm_param_segment) { '/prod/foo' }
  let(:ssm_param_no_env) { '/foo/bar/bat' }
  let(:response) { { 'Version': 1, 'Tier': 'Standard' } }

  describe '.trim_environment' do
    it 'removes a string from a param' do
      expect(described_class.trim_environment(ssm_param, 'prod')).to eq('/foo/bar/baz')
    end
    it 'removes a leading /' do
      expect(described_class.trim_environment(ssm_param_segment, 'prod')).to eq('foo')
    end
    it 'does not modify' do
      expect(described_class.trim_environment(ssm_param_no_env, 'prod')).to eq(ssm_param_no_env)
    end
  end

  describe 'intialize' do
    it 'raises' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end
    it 'validates' do
      expect { described_class.new(profile, mock_response) }.not_to raise_error
    end
  end

  describe 'perform' do
    it 'returns an array' do
      push = described_class.new(profile, mock_response['Parameters'].take(1))
      allow(push).to receive(:send_param_to_aws).and_return(:success)
      expect(push.perform).to eq(mock_response['Parameters'].take(1))
    end
  end
end
