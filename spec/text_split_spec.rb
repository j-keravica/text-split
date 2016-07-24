require "spec_helper"
require "./text_split"

RSpec.describe TextSplit do

  def app
    TextSplit
  end

  describe "POST /split" do
    it "returns splitted words and page title" do
      post "/split", { :url => File.join(settings.root, "/spec/lib/example.html") }
      puts last_response.body["words"]
      byebug
      expect(last_response.body["words"]).to include("ok", "to")
    end
  end
end
