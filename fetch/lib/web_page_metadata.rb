# frozen_string_literal: true

# Goes through the html contents and gets the metadata to print
class WebPageMetadata
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
    0
  end

  def find_number_of_images
    0
  end

  def find_metadata
    @number_of_links = find_number_of_links
    @number_of_images = find_number_of_images
  end
end
