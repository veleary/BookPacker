module BooksHelper
  require 'json'
  def create_box(id, weight)
        
    box = {"box" => {"id" => id, "total_weight" => weight, "contents" => []}}
    @boxes << box      
    pack_books
  end

  def ship_weight_list(books)
    @weights = []
    Book.all.each do |book|       
      @weights << book.ship_weight     
    end 
    @boxes = []
    create_box(1, 0)
  end

  def pack_books       
    @weights.each_with_index do  |weight, index|
      box = @boxes.last
      sum = weight.to_f + box["box"]["total_weight"]
      if  sum <= 10
        box["box"]["total_weight"] += weight.to_f
        book = Book.find_by_ship_weight(weight)
        content_info = {
          "title:" => book.title, 
          "author:" => book.author,       
          "price:" => book.price,
          "ship_weight:" => book.ship_weight,
          "isbn10:" => book.isbn10,
          "isbn13:" => book.isbn13,
          "total_pages:" => book.total_pages,
          "publisher:" => book.publisher,
          "language:" => book.language
        }
        box["box"]["contents"] << content_info
        @weights.delete_at(index)
      else
        new_box_id = box["box"]["id"] + 1
        create_box(new_box_id, 0)       
      end
    end
  end


  def packing_list
    JSON.pretty_generate(@boxes).html_safe;    
  end
end
