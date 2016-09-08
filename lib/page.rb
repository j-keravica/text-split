require "open-uri"
require_relative "exceptions"

class Page

  LOOKS_LIKE_XPATH = /^(\.\/|\/|\.\.|\.$)/
  # this regular expression can be found in
  # Nokogiri::XML::Searchable

  def self.extract(url, xpath)
    new(url, xpath)
  end

  def initialize(url, xpath)
    @doc = Nokogiri::HTML(open(url).read)
    @xpath = xpath
  end

  def text
    (@xpath.nil? || @xpath.empty?) ? content : custom_content
  end

  def title
    @doc.xpath('/html/head/title').text
  end

  def content
    @doc.xpath('//h1 | //p').reduce("") do |text, node|
      text = text + " " + node.text
    end
  end

  def custom_content
    if @xpath =~ LOOKS_LIKE_XPATH
      @doc.xpath(@xpath).reduce("") do |text, node|
        text = text + " " + node.text
      end
    else
      raise Exceptions::InvalidPath
    end
  end

end
