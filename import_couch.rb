require 'rubygems'
require 'couchrest'
require 'open-uri'
require 'net/http'
require 'rexml/document'

baza = CouchRest.database!('http://127.0.0.1:14014/books')

200.times do |i|
	xml = Net::HTTP.get_response(URI.parse('http://isbndb.com/api/books.xml?access_key=4K8HD2R9&page_number=' + i.to_s  + '&index0=full&value1=Shakespeare'))
	doc = REXML::Document.new(xml.body)

	doc.elements.each('ISBNdb/BookList/BookData') do |elem|
		book = {}
		book['book_id'] = elem.attributes['book_id'].to_s
		book['isbn'] = elem.attributes['isbn'].to_s
		book['isbn13'] = elem.attributes['isb13'].to_s
		book['title'] = elem.elements['Title'].text
		book['title_long'] = elem.elements['TitleLong'].text
		book['authors'] = elem.elements['AuthorsText'].text
		book['publisher'] = elem.elements['PublisherText'].text

		baza.save_doc(book)
	end
end
