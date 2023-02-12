# frozen_string_literal: true

require 'nokogiri'

# Goes through the html contents and gets the metadata to print
class WebPageMetadata
  attr_reader :host, :number_of_links, :number_of_images, :last_fetch

  def initialize(host, html, last_fetch_at)
    @host = host
    @html = html
    @number_of_links = 0
    @number_of_images = 0
    @last_fetch_at = last_fetch_at.strftime('%a %b %d %Y %H:%M %Z')

    find_metadata
  end

  def metadata
    <<~META
      site: #{@host}
      num_links: #{@number_of_links}
      images: #{@number_of_images}
      last_fetch: #{@last_fetch_at}

    META
  end

  private

  def find_number_of_links
    Nokogiri::HTML.parse(@html).css('a').count
  end

  def find_number_of_images
    Nokogiri::HTML.parse(@html).css('img').count
  end

  def find_metadata
    @number_of_links = find_number_of_links
    @number_of_images = find_number_of_images
  end
end
