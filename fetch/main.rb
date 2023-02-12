# frozen_string_literal: true

require_relative 'lib/web_page'
require_relative 'lib/web_page_writer'
require_relative 'lib/web_page_metadata'

def fetch(url)
  web_page = WebPage.new(url)
  web_page.fetch_html
  web_page
end

def write_to_file(web_page)
  WebPageWriter.new(
    web_page.host,
    web_page.html
  ).write_file
end

def write_metadata(web_page)
  puts WebPageMetadata.new(
    web_page.host,
    web_page.html,
    Time.now.utc
  ).metadata
end

def main(urls)
  urls.each do |url|
    web_page = fetch(url)

    if web_page.html
      write_to_file(web_page)
      write_metadata(web_page)
    end
  end
end

main(ARGV)
