require "./lib/page"
require "json"

class TextSplit < Sinatra::Base

  post "/split", :provides => :json do
    url = params[:url]

    begin
      extracted_page = Page.extract(url)

      content_type :json
      json({
        :title => extracted_page.title,
        :text => extracted_page.text
      })
    rescue Errno::ENOENT, OpenURI::HTTPError
      halt 404
    end
  end

end
