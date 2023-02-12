# frozen_string_literal: true

require_relative '../lib/web_page_metadata'
require 'faker'
require 'open-uri'

describe WebPageMetadata do
  let(:host) { URI.parse(Faker::Internet.url).host }
  let(:html) { Faker::Lorem.sentences }
  let(:number_of_links) { Faker::Number.between(from: 1, to: 50) }
  let(:number_of_images) { Faker::Number.between(from: 1, to: 50) }
  let(:last_fetch_at) { Time.now.utc }
  let(:instance) { described_class.new(host, html, last_fetch_at) }

  describe '.metadata' do
    let(:metadata) do
      <<~META
        site: #{host}
        num_links: #{number_of_links}
        images: #{number_of_images}
        last_fetch: #{last_fetch_at.strftime('%a %b %d %Y %H:%M %Z')}

      META
    end

    before do
      # rubocop:disable RSpec/AnyInstance
      allow_any_instance_of(described_class).to receive(:find_number_of_links).and_return(number_of_links)
      allow_any_instance_of(described_class).to receive(:find_number_of_images).and_return(number_of_images)
      # rubocop:enable RSpec/AnyInstance
    end

    it 'returns truthy' do
      expect(instance.metadata).to eq(metadata)
    end
  end

  describe '.number_of_links' do
    let(:html) do
      <<-HTML_END
        <div class="example1">
          <a href='http://example.org/site/1/'>site 1</a>
          <a href='http://example.org/site/2/'>site 2</a>
          <a href='http://example.org/site/3/'>site 3</a>
        </div>
        <div class="example2">
          <a href='http://example.org/site/4/'>site 4</a>
          <a href='http://example.org/site/5/'>site 5</a>
          <a href='http://example.org/site/6/'>site 6</a>
        </div>
      HTML_END
    end

    it 'finds the links' do
      expect(instance.number_of_links).to eq(6)
    end

    context 'with invalid html' do
      let(:html) { '' }

      it 'does not find any links' do
        expect(instance.number_of_links).to eq(0)
      end
    end
  end

  describe '.number_of_images' do
    let(:html) do
      <<-HTML_END
        <div class="example1">
          <img src="example" />
          <img src="example" />
          <img src="example" />
        </div>
        <div class="example2">
          <img src="example" />
          <img src="example" />
        </div>
      HTML_END
    end

    it 'finds the images' do
      expect(instance.number_of_images).to eq(5)
    end

    context 'with invalid html' do
      let(:html) { '' }

      it 'does not find any images' do
        expect(instance.number_of_images).to eq(0)
      end
    end
  end
end
