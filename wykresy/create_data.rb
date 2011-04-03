#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'net/http'
require 'json'


resp = Net::HTTP.get_response(URI.parse("http://sigma.ug.edu.pl:14014/b/_design/app/_view/by_numbers?group_level=1"))
result = JSON.parse(resp.body)
max = 0
result['rows'].each do |r| max = r["value"] if r["value"] > max end

data = File.open("data_numbers	.js", "w")
data.puts("var max = " + max.to_s + "; var isbn_by_numbers = " + resp.body[8..-3])
