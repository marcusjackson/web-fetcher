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
end
