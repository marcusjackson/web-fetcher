# frozen_string_literal: true

require_relative 'lib/web_page'
require_relative 'lib/web_page_writer'
require_relative 'lib/web_page_metadata'
require_relative 'lib/argument_flag_parser'

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

def main(has_metadata_flag, urls)
  urls.each do |url|
    web_page = fetch(url)

    if web_page.html
      write_to_file(web_page)
      write_metadata(web_page) if has_metadata_flag
    end
  end
end

has_metadata_flag, urls = ArgumentFlagParser.check_for_metadata_flag(ARGV)
main(has_metadata_flag, urls)
