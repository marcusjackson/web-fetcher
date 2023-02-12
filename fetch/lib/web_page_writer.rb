# frozen_string_literal: true

# Writes the html contents of a web page to file
class WebPageWriter
  TEMP_DIR = 'temp'

  def initialize(host, html, write_metadata: true)
    @host = host
    @html = html
    @write_metadata = write_metadata
  end

  def write_file
    result = File.write(File.join(TEMP_DIR, "#{@host}.html"), @html.to_s)
    write_metadata if @write_metadata
    result
  end

  def write_metadata
    puts "site: #{@host}"
  end
end
