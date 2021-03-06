require "spec_helper"
require "./text_split"

RSpec.describe TextSplit do

  def app
    TextSplit
  end

  describe "POST /split" do
    context "without xpath" do
      it "returns splitted words and page title" do
        VCR.use_cassette("example_page") do
          post "/split", { :url => "https://medium.com/@jamievaron/hey-internet-stop-trying-to-inspire-me-b5022f3c0f7" }
          response = JSON.parse(last_response.body)

          expect(response["text"]).to include("ultra-positive", "Inspiration", "contemplative", "okay", "angry")
          expect(response["text"].length).to eq(4414)
          expect(response["title"]).to include("Stop Trying To Inspire Me")
        end
      end
    end

    context "with xpath" do
      it "returns splitted words and page title" do
        VCR.use_cassette("example_page_xpath") do
          post "/split", { :url => "https://medium.com/@jamievaron/hey-internet-stop-trying-to-inspire-me-b5022f3c0f7", :xpath => "//p[@name='2201']" }
          response = JSON.parse(last_response.body)

          expect(response["text"]).to include("happens", "reason")
          expect(response["text"].length).to eq(35)
          expect(response["title"]).to include("Stop Trying To Inspire Me")
        end
      end
    end
  end
end
