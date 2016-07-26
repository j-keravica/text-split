require "./lib/page"

class TextSplit < Sinatra::Base

	post "/split", :provides => :json do
	  url = params[:url]
    # elements = params[:elements]

    extracted_page = Page.extract(url)

    json({
      :title => extracted_page.title,
      :text => extracted_page.text
    })
	end

end
