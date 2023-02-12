# frozen_string_literal: true

require_relative '../lib/web_page_writer'
require 'faker'
require 'open-uri'

describe WebPageWriter do
  let(:host) { URI.parse(Faker::Internet.url).host }
  let(:html) { Faker::Lorem.sentences }
  let(:instance) { described_class.new(host, html) }

  describe '.write_file' do
    before do
      allow(File).to receive(:write).and_return(Faker::Number.number(digits: 5))
    end

    it 'returns truthy' do
      expect(instance.write_file).to be_truthy
    end
  end
end
