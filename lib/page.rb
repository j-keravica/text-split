require "open-uri"
require "exceptions"

class Page

  LOOKS_LIKE_XPATH = /^(\.\/|\/|\.\.|\.$)/
  # this regular expression can be found in
  # Nokogiri::XML::Searchable

  def self.extract(url)
    new(url)
  end

  def initialize(url)
    @doc = Nokogiri::HTML(open(url).read)
  end

  def text
    @doc.xpath('//h1 | //p').reduce("") do |text, node|
      text = text + " " + node.text
    end
  end

  def title
    @doc.xpath('/html/head/title').text
  end

  def custom_content(path)
    if path =~ LOOKS_LIKE_XPATH
      @doc.xpath(path).reduce("") do |text, node|
        text = text + " " + node.text
      end
    else
      raise Exceptions::InvalidPath
    end
  end

end
