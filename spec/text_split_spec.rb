require "spec_helper"
require "./text_split"

RSpec.describe TextSplit do

  def app
    TextSplit
  end

  describe "POST /split" do
    it "returns splitted words and page title" do
      VCR.use_cassette("example_page") do
        post "/split", { :url => "https://medium.com/@jamievaron/hey-internet-stop-trying-to-inspire-me-b5022f3c0f7" }
        response = JSON.parse(last_response.body)

        expect(response["words"]).to include("ultra-positive", "Inspiration", "contemplative", "okay", "angry")
        expect(response["words"].size).to eq(815)
        expect(response["title"]).to include("Stop Trying To Inspire Me")
      end
    end
  end
end
