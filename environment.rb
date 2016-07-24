require "rubygems"
require "bundler"
require "dotenv"

Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems
Dotenv.load

ENV["RACK_ENV"] = "test"

require './text_split.rb'
