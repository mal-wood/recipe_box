require "net/http"
require "uri"
require 'nokogiri'
require_relative 'HTMLWhitespaceCleaner'

puts "URL:"
user_input = gets.chomp
url = user_input

# standard HTTP Request
uri = URI.parse(url)
# returns a NET object
response = Net::HTTP.get_response(uri)
html_body = response.body

#cleans whitespace from HTML 
clean_response = HTMLWhitespaceCleaner.clean(html_body)
#turns HTML into Nokogiri object 
nokogiri_object = Nokogiri.parse(clean_response)

title = nokogiri_object.css('title').text
title = title.gsub(" - Allrecipes.com", "")
p title 

ingredients = nokogiri_object.css('li.checkList__line').text
ingredients = ingredients.gsub("ADVERTISEMENT", " +")
ingredients = ingredients.gsub("Add all ingredients to list", "")
ingredients = ingredients.split(" +")
p ingredients

directions = nokogiri_object.css('div.directions--section__steps').text
directions = directions.split(".")
directions.each {|step| p step}

#TEXT FUNCTIONALITY 
# allow user to text themselves a grocery list for the recipe!! 



