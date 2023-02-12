# frozen_string_literal: true

# Writes the html contents of a web page to file
class WebPageWriter
  TEMP_DIR = 'temp'

  def initialize(host, html)
    @host = host
    @html = html
  end

  def write_file
    File.write(File.join(TEMP_DIR, "#{@host}.html"), @html.to_s)
  end
end
