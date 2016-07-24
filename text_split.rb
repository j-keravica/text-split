require "./lib/page"

configure do
  set :root, File.dirname(__FILE__)
end

class TextSplit < Sinatra::Base

	post "/split" do
	  url = params[:url]
    # elements = params[:elements]

    extracted_page = Page.extract(url)
    words = extracted_page.text.split

    json({
      :title => extracted_page.title,
      :words => words
    })
	end

end
