# frozen_string_literal: true

require 'faker'
require_relative '../lib/argument_flag_parser'

describe ArgumentFlagParser do
  let(:urls) { [Faker::Internet.url, Faker::Internet.url, Faker::Internet.url] }

  describe '.check_for_metadata_flag' do
    context 'with flag' do
      let(:arguments) { ['--metadata'] + urls }

      it 'finds the flag' do
        expect(described_class.check_for_metadata_flag(arguments)).to eq([true, urls])
      end
    end

    context 'without flag' do
      let(:arguments) { urls }

      it 'does not find the flag' do
        expect(described_class.check_for_metadata_flag(arguments)).to eq([false, urls])
      end
    end

    context 'with empty arguments' do
      let(:arguments) { [] }

      it 'does not find the flag' do
        expect(described_class.check_for_metadata_flag(arguments)).to eq([false, []])
      end
    end
  end
end
