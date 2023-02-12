# frozen_string_literal: true

require 'net/http'
require 'open-uri'

# Represents the web pages to be fetched
class WebPage
  attr_reader :url, :html

  def initialize(url)
    @url = url
    @uri = URI.parse(url)
  end

  def host
    @uri ? @uri.host : ''
  end

  def fetch_html
    response = Net::HTTP.get_response(@uri)
    @html = response.body
  rescue StandardError => e
    puts <<~ERROR
      Error (#{url}): #{e}

    ERROR
  end
end
