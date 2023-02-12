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

  describe '.fetch_html' do
    let(:response) { instance_double(Net::HTTPResponse) }

    before do
      allow(Net::HTTP).to receive(:get_response).and_return(response)
      allow(response).to receive(:body).and_return(Faker::Lorem.sentences)
    end

    it 'returns html' do
      expect(instance.fetch_html).to be_truthy
    end

    context 'with invalid url' do
      before do
        allow(Net::HTTP).to receive(:get_response).and_raise(Errno::EADDRNOTAVAIL)
      end

      it 'cannot get html' do
        expect(instance.fetch_html).to be_falsey
      end
    end
  end
end
