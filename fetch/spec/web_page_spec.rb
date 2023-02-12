# frozen_string_literal: true

require_relative '../lib/web_page'
require 'faker'

describe WebPage do
  let(:url) { Faker::Internet.url }
  let(:instance) { described_class.new(url) }

  describe '.host' do
    it 'has a host' do
      expect(instance.host).to be_truthy
    end

    context 'with invalid url' do
      let(:url) { 'abc' }

      it 'has empty host' do
        expect(instance.host).to be_falsey
      end
    end
  end
end
