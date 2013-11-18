desc "Fetch Booklist Details"

task :fetch_book_details => :environment do
  require 'nokogiri'  
  Book.all.each do |book|
    doc = Nokogiri::HTML(File.read("data/#{book.filename}"))   
    title = doc.at_css("strong:nth-child(1) a").text
    author = doc.at_css(".buying span a").text
    price = doc.at_css(".bb_price").text
    ship_weight = doc.at_css("#productDetailsTable li:nth-child(7)").text
    isbn10 = doc.at_css("#productDetailsTable li:nth-child(4)").text
    isbn13 = doc.at_css("#productDetailsTable li:nth-child(5)").text
    total_pages = doc.at_css("#productDetailsTable li:nth-child(1)").text
    publisher = doc.at_css("#productDetailsTable li:nth-child(2)").text
    language = doc.at_css("#productDetailsTable li:nth-child(3)").text
    description = doc.at_css("#postBodyPS div").text
    book.update_attributes(title: title, author: author, price: price, ship_weight: ship_weight, isbn10: isbn10, isbn13: isbn13, total_pages: total_pages, publisher: publisher, language: language)    
  end
end