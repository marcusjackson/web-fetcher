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
end
