# frozen_string_literal: true

require_relative '../lib/web_page'
require 'faker'

describe WebPage do
  let(:instance) { described_class.new(Faker::Internet.url) }

  it 'has a host' do
    expect(instance.host).to be_truthy
  end
end
