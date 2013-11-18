module BooksHelper
  require 'json'
  def create_box(id, weight)
        
    box = {"id" => id, "Total_Weight" => weight, "Book_list" => []}
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
      sum = weight.to_f + box["Total_Weight"]
      if  sum <= 10
        box["Total_Weight"] += weight.to_f
        box["Book_list"] <<  Book.find_by_ship_weight(weight).title
        @weights.delete_at(index)
      else
        new_box_id = box["id"] + 1
        create_box(new_box_id, 0)       
      end
    end
  end


  def packing_list
    return JSON.pretty_generate(@boxes).html_safe;
    # return @boxes
      # Box_Number = box[id] 

    # return @boxes.last
    # return @weights
    # return @box_list
  end
end
